import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/models/self_receipt_model.dart';
import 'package:mobile_app/network/rest_apis/receipts.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:mobile_app/utils/constants.dart';
import 'package:mobile_app/widgets/loader_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class SelfReceiptReasonView extends StatelessWidget {
  final SelfReceiptModel receipt;
  const SelfReceiptReasonView({super.key, required this.receipt});

  void _getReceiptByMail() async {
    appStore.setLoading(true);
    HttpResponseModel? response = await getSelfReceiptByMail(receipt.id);
    appStore.setLoading(false);

    toast(response?.msg ?? "");
  }

  Widget _headingWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              receipt.purpose,
              style: boldTextStyle(size: LABEL_TEXT_SIZE, color: primaryColor),
            ),
            Text(
              receipt.receiptNumber,
              style: secondaryTextStyle(),
            ),
          ],
        ).flexible(flex: 3),
        8.width,
        Center(
          child: Text(
            '$CURRENCY_SYMBOL${receipt.amount.validate().toString()}',
            style: boldTextStyle(size: LABEL_TEXT_SIZE),
          ),
        )
      ],
    );
  }

  Widget _receiptWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          language.recipient,
          style: boldTextStyle(),
        ),
        8.height,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Text(
                receipt.recipient,
                style: primaryTextStyle(),
              ),
              Divider(
                color: context.dividerColor,
                indent: 0,
                height: 1,
              ).opacity(opacity: .3),
            ],
          ),
        )
      ],
    );
  }

  Widget _reasonWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          language.selfReceiptReason,
          style: boldTextStyle(),
        ),
        8.height,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Text(
                receipt.reason,
                style: primaryTextStyle(),
              ),
              Divider(
                color: context.dividerColor,
                indent: 0,
                height: 1,
              ).opacity(opacity: .3),
            ],
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
          language.selfReceiptReason,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headingWidget(context),
                  16.height,
                  _receiptWidget(context),
                  16.height,
                  _reasonWidget(context),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: AppButton(
              width: double.infinity,
              color: primaryColor,
              textColor: Colors.white,
              onTap: () {
                _getReceiptByMail();
              },
              text: language.sendOverMail,
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
