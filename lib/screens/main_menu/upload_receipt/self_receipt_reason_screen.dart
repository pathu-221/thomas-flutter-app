import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/network/rest_apis/upload_receipt.dart';
import 'package:mobile_app/utils/common.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:mobile_app/widgets/loader_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class SelfReceiptReasonScreen extends StatefulWidget {
  const SelfReceiptReasonScreen({super.key});

  @override
  State<SelfReceiptReasonScreen> createState() =>
      _SelfReceiptReasonScreenState();
}

class _SelfReceiptReasonScreenState extends State<SelfReceiptReasonScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? selectedImage;
  TextEditingController receiptNumberCont = TextEditingController();
  TextEditingController amountCont = TextEditingController();
  TextEditingController recipientCont = TextEditingController();
  TextEditingController purposeCont = TextEditingController();
  TextEditingController reasonCont = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    receiptNumberCont.dispose();
    amountCont.dispose();
    recipientCont.dispose();
    purposeCont.dispose();
    reasonCont.dispose();
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

  void _handleSubmit() async {
    if (!formKey.currentState!.validate()) return;
    Map requestFields = {
      "receiptNumber": receiptNumberCont.text.validate(),
      "amount": amountCont.text.validate(),
      "recipient": recipientCont.text.validate(),
      "purpose": purposeCont.text.validate(),
      "reason": reasonCont.text.validate(),
    };

    if (selectedImage == null) {
      appStore.setLoading(true);
      HttpResponseModel? response = await uploadSelfReceipt(requestFields);
      appStore.setLoading(false);
      if (response == null) {
        toast("Something went wrong!");
        return;
      }

      if (response.status == 1) {
        toast(response.msg);
        finish(context);
      } else {
        toast(response.msg);
      }
    } else {
      appStore.setLoading(true);
      HttpResponseModel? response = await sendMultipartRequest(
          selectedImage!, '/self-receipt', requestFields);
      if (response != null) {
        if (response.status == 1) {
          toast(response.msg);
          finish(context);
        } else {
          toast(response.msg);
        }
      }
      appStore.setLoading(false);
    }
  }

  Widget _imageWidget() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                  selectedImage = null;
                });
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _titleWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            language.selfReceiptReason,
            style: boldTextStyle(size: 28),
          ),
        ],
      ),
    );
  }

  Widget _formInputFieldWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextField(
          controller: receiptNumberCont,
          textFieldType: TextFieldType.NUMBER,
          decoration:
              inputDecoration(context, labelText: language.receiptNumber),
        ),
        16.height,
        AppTextField(
          controller: amountCont,
          textFieldType: TextFieldType.NUMBER,
          decoration: inputDecoration(context,
              labelText: "${language.amount} ($CURRENCY_SYMBOL)"),
        ),
        16.height,
        AppTextField(
          controller: recipientCont,
          textFieldType: TextFieldType.NAME,
          decoration: inputDecoration(context, labelText: language.recipient),
        ),
        16.height,
        AppTextField(
          controller: purposeCont,
          textFieldType: TextFieldType.NAME,
          decoration: inputDecoration(context,
              labelText: language.entertainmentPurpose),
        ),
        16.height,
        AppTextField(
          controller: reasonCont,
          textFieldType: TextFieldType.NAME,
          decoration:
              inputDecoration(context, labelText: language.selfReceiptReason),
        ),
        16.height,
        Row(
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
        ),
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
          language.selfReceiptReason,
          style: boldTextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
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
