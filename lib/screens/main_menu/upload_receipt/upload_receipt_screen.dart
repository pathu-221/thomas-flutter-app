import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:image_picker/image_picker.dart';

class UploadReceiptScreen extends StatefulWidget {
  const UploadReceiptScreen({super.key});

  @override
  State<UploadReceiptScreen> createState() => _UploadReceiptScreenState();
}

class _UploadReceiptScreenState extends State<UploadReceiptScreen> {
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          language.uploadReceipt,
          style: boldTextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppButton(
                width: context.width(),
                color: primaryColor,
                textColor: Colors.white,
                text: language.uploadReceipt,
                onTap: () {
                  _showBottomSheet(context);
                },
              ),
            ]),
      ),
    );
  }
}
