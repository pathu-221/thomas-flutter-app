import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/network/rest_apis/upload_receipt.dart';
import 'package:mobile_app/utils/common.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';

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
  File? selectedImage;

  void _pickFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  void _pickFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  void _handleSubmit() async {
    if (selectedImage == null) {
      toast(language.pleaseUploadImage);
      return;
    }

    Map<String, dynamic> request = {
      "cateringDate": pickedDate!.millisecondsSinceEpoch.toString(),
      "cateringAddress": locationController.text.validate(),
      "occassion": occasionController.text.validate(),
      "noOfPeople": personsController.text.validate(),
      "amount": amountCont.text.validate(),
    };


    HttpResponseModel? response = await uploadEntertainmenReceipt(
        selectedImage!, '/entertainment-receipt', request);
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
              onTap: () {
                _pickFromCamera();
                finish(context);
              },
            ),
            SettingItemWidget(
              title: language.gallery,
              leading: const Icon(
                Icons.image,
                color: primaryColor,
              ),
              onTap: () {
                _pickFromGallery();
                finish(context);
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
    final DateTime picked = (await showDatePicker(
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
              textFieldType: TextFieldType.OTHER,
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
          textFieldType: TextFieldType.OTHER,
          controller: locationController,
          decoration: inputDecoration(context,
              labelText: language.entertainmentReceiptLocation),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.OTHER,
          controller: occasionController,
          decoration: inputDecoration(context,
              labelText: language.entertainmentReceiptOccasion),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.OTHER,
          controller: personsController,
          decoration:
              inputDecoration(context, labelText: language.entertainedPersons),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.NUMBER,
          controller: amountCont,
          decoration: inputDecoration(context, labelText: language.amount),
        ),
      ],
    );
  }

  Widget uploadImage() {
    return AppButton(
      color: primaryColor,
      textColor: Colors.white,
      onTap: () {
        _showBottomSheet(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.add,
            color: Colors.white,
          ),
          4.width,
          Text(
            language.uploadImage,
            style: boldTextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _imageWidget() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Image.file(selectedImage!, height: 100), // Display the selected image
        Positioned(
          right: -2,
          top: -9,
          child: Container(
            color: primaryColor,
            child: GestureDetector(
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              // You can change the icon as needed
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
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _titleWidget(),
              16.height,
              uploadImage(),
              if (selectedImage != null) ...[16.height, _imageWidget()],
              16.height,
              _formInputFieldWidget(),
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
    );
  }
}
