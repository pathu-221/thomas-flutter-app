import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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

  void _handleSubmit() async {
    if (!formKey.currentState!.validate()) return;

    Map requestFields = {
      "receiptNumber": receiptNumberCont.text.validate(),
      "amount": amountCont.text.toDouble().validate(),
      "recipient": recipientCont.text.validate(),
      "purpose": purposeCont.text.validate(),
      "reason": reasonCont.text.validate(),
    };
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
          decoration: inputDecoration(context, labelText: language.amount),
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
