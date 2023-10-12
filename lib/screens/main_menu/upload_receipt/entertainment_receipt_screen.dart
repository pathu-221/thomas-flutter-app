import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/utils/common.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class EntertainmentReceiptScreen extends StatefulWidget {
  const EntertainmentReceiptScreen({super.key});

  @override
  State<EntertainmentReceiptScreen> createState() =>
      _EntertainmentReceiptScreenState();
}

class _EntertainmentReceiptScreenState
    extends State<EntertainmentReceiptScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _pickFromCamera() async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
  }

  void _pickFromGallery() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
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

  Widget _formInputFieldWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextField(
          textFieldType: TextFieldType.OTHER,
          decoration: inputDecoration(context,
              labelText: language.entertainmentReceiptDate),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.OTHER,
          decoration: inputDecoration(context,
              labelText: language.entertainmentReceiptLocation),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.OTHER,
          decoration: inputDecoration(context,
              labelText: language.entertainmentReceiptOccasion),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.OTHER,
          decoration:
              inputDecoration(context, labelText: language.entertainedPersons),
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
              16.height,
              _formInputFieldWidget(),
              16.height,
              AppButton(
                width: context.width(),
                onTap: () {},
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
