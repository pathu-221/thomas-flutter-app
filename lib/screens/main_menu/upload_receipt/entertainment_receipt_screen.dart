import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/network/rest_apis/upload_receipt.dart';
import 'package:mobile_app/utils/common.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:mobile_app/widgets/loader_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EntertainmentReceiptScreen extends StatefulWidget {
  const EntertainmentReceiptScreen({super.key});

  @override
  State<EntertainmentReceiptScreen> createState() =>
      _EntertainmentReceiptScreenState();
}

class _EntertainmentReceiptScreenState
    extends State<EntertainmentReceiptScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? pickedDate;
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountCont = TextEditingController();
  final TextEditingController occasionController = TextEditingController();
  final TextEditingController personsController = TextEditingController();
  final TextEditingController tipAmountCont = TextEditingController();
  File? selectedImage;
  List<String> entertainedPersons = [];

  void _handleSubmit() async {
    if (selectedImage == null) {
      toast(language.pleaseUploadImage);
      return;
    }

    if (entertainedPersons.isEmpty) {
      toast(language.addAtleastOnePerson);
      return;
    }

    if (!formKey.currentState!.validate()) return;

    Map<String, dynamic> request = {
      "cateringDate": pickedDate!.millisecondsSinceEpoch.toString(),
      "cateringAddress": locationController.text.validate(),
      "occassion": occasionController.text.validate(),
      "entertainedPersons": jsonEncode(entertainedPersons),
      "amount": amountCont.text.validate(),
      "tipAmount": tipAmountCont.text.validate()
    };

    appStore.setLoading(true);

    HttpResponseModel? response = await sendMultipartRequest(
            selectedImage!, '/entertainment-receipt', request)
        .catchError((error) {
      toast('Something went wrong!');
      return null;
    });

    appStore.setLoading(false);

    if (response != null) {
      toast(response.msg);

      if (response.status == 1) {
        finish(context);
      }
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.cardColor,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SettingItemWidget(
              title: language.camera,
              leading: const Icon(
                Icons.camera,
                color: primaryColor,
              ),
              onTap: () async {
                await pickImageFromCamera().then((value) {
                  if (value != null) {
                    selectedImage = File(value.path);
                    setState(() {});
                  }
                  finish(context);
                }).catchError((error) {
                  //
                });
              },
            ),
            SettingItemWidget(
              title: language.gallery,
              leading: const Icon(
                Icons.image,
                color: primaryColor,
              ),
              onTap: () async {
                await pickImageFromGallery().then((value) {
                  if (value != null) {
                    selectedImage = File(value.path);
                    setState(() {});
                  }
                  finish(context);
                }).catchError((error) {
                  //
                });
              },
            ),
          ],
        ).paddingAll(16);
      },
    );
  }

  Widget _titleWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            language.entertainmentReceipt,
            style: boldTextStyle(size: 28),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    if (picked != null) {
      pickedDate = picked;
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
  }

  Widget _personsInputFieldWidget() {
    return Column(
      children: [
        AppTextField(
          textFieldType: TextFieldType.OTHER,
          controller: personsController,
          decoration:
              inputDecoration(context, labelText: language.entertainedPersons),
          suffix: IconButton(
            color: primaryColor,
            onPressed: () {
              if (personsController.text.isEmpty) {
                toast(language.emptyValueError);
                return;
              }
              entertainedPersons.add(personsController.text);
              personsController.text = '';
              setState(() {});
            },
            icon: const Icon(Icons.add),
          ),
        ),
        if (entertainedPersons.isNotEmpty)
          for (String persons in entertainedPersons)
            Container(
              padding: const EdgeInsets.only(top: 8),
              child: Stack(
                children: [
                  AppTextField(
                    textFieldType: TextFieldType.OTHER,
                    decoration: inputDecoration(context, labelText: persons),
                    enabled: false,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () {
                        entertainedPersons.remove(persons);
                        setState(() {});
                      },
                      child: IconButton(
                        color: primaryColor,
                        onPressed: () {
                          entertainedPersons.remove(persons);
                          setState(() {});
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }

  Widget _formInputFieldWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _selectDate(context); // Show the date picker on tap
          },
          child: AbsorbPointer(
            child: AppTextField(
              textFieldType: TextFieldType.NAME,
              controller: dateController,
              decoration: inputDecoration(
                context,
                labelText: language.entertainmentReceiptDate,
              ),
            ),
          ),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.MULTILINE,
          controller: locationController,
          decoration: inputDecoration(context,
              labelText: language.entertainmentReceiptLocation),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.NAME,
          controller: occasionController,
          decoration: inputDecoration(context,
              labelText: language.entertainmentReceiptOccasion),
        ),
        16.height,
        _personsInputFieldWidget(),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.NUMBER,
          controller: amountCont,
          decoration: inputDecoration(context,
              labelText: "${language.amount} ($CURRENCY_SYMBOL)"),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.NUMBER,
          controller: tipAmountCont,
          decoration: inputDecoration(context,
              labelText: "${language.tipAmount} ($CURRENCY_SYMBOL)"),
        ),
      ],
    );
  }

  Widget uploadImage() {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            onTap: () {
              _showBottomSheet(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.add,
                  color: primaryColor,
                ),
                4.width,
                Text(
                  selectedImage == null
                      ? language.uploadImage
                      : language.changeImage,
                  style: boldTextStyle(color: primaryColor),
                ),
              ],
            ),
          ),
        ),
        if (selectedImage != null) ...[
          8.width,
          _imageWidget(),
        ]
      ],
    );
  }

  Widget _imageWidget() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Image.file(
            selectedImage!,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: primaryColor),
            child: GestureDetector(
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onTap: () {
                setState(() {
                  selectedImage = null; // Remove the selected image
                });
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          language.entertainmentReceipt,
          style: boldTextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 32),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _titleWidget(),
                    16.height,
                    _formInputFieldWidget(),
                    16.height,
                    uploadImage(),
                    16.height,
                    AppButton(
                      width: context.width(),
                      onTap: _handleSubmit,
                      text: language.submit,
                      color: primaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Observer(
            builder: (_) => const LoaderWidget().visible(appStore.isLoading),
          ),
        ],
      ),
    );
  }
}
