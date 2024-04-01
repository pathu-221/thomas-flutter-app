import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/screens/main_menu/upload_receipt/entertainment_receipt_screen.dart';
import 'package:mobile_app/screens/main_menu/upload_receipt/self_receipt_reason_screen.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class UploadReceiptScreen extends StatefulWidget {
  const UploadReceiptScreen({super.key});

  @override
  State<UploadReceiptScreen> createState() => _UploadReceiptScreenState();
}

class _UploadReceiptScreenState extends State<UploadReceiptScreen> {
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
                text: language.entertainmentReceipt,
                onTap: () {
                  const EntertainmentReceiptScreen().launch(context);
                },
              ),
              16.height,
              AppButton(
                width: context.width(),
                color: primaryColor,
                textColor: Colors.white,
                text: language.selfReceiptReason,
                onTap: () {
                  //_showBottomSheet(context);
                  const SelfReceiptReasonScreen().launch(context);  
                },
              ),
            ]),
      ),
    );
  }
}
