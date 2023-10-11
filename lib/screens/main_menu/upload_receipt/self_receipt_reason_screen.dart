import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/utils/common.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class SelfReceiptReasonScreen extends StatefulWidget {
  const SelfReceiptReasonScreen({super.key});

  @override
  State<SelfReceiptReasonScreen> createState() =>
      _SelfReceiptReasonScreenState();
}

class _SelfReceiptReasonScreenState extends State<SelfReceiptReasonScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget _titleWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            language.receiptNumber,
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
          decoration:
              inputDecoration(context, labelText: language.receiptNumber),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.OTHER,
          decoration: inputDecoration(context, labelText: language.amount),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.OTHER,
          decoration: inputDecoration(context, labelText: language.recipient),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.OTHER,
          decoration: inputDecoration(context,
              labelText: language.entertainmentPurpose),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.OTHER,
          decoration:
              inputDecoration(context, labelText: language.selfReceiptReason),
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
