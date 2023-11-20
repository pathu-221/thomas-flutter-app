import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/entertainment_receipt_model.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:mobile_app/utils/constants.dart';
import 'package:mobile_app/widgets/loader_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class EntertainmentReceiptView extends StatelessWidget {
  final EntertainmentReceiptModel receipt;
  const EntertainmentReceiptView({super.key, required this.receipt});

  Widget _headingWidget(BuildContext context) {
    String formattedDate =
        DateFormat('dd-MMM-yyyy', 'en_US').format(receipt.createdAt);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              receipt.occasion,
              style: boldTextStyle(size: LABEL_TEXT_SIZE, color: primaryColor),
            ),
            Text(
              formattedDate,
              style: secondaryTextStyle(),
            ),
          ],
        ).flexible(flex: 3),
        8.width,
        InkWell(
          onTap: () {
            _buildImagePreview(context).launch(context);
          },
          child: Image.network(
            '$BASE_URL/${receipt.image}',
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _amountWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          language.amount,
          style: boldTextStyle(),
        ),
        8.height,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(language.amount),
                  Text(
                    receipt.amount.validate().toString(),
                    style: boldTextStyle(),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  color: context.dividerColor,
                  indent: 0,
                  height: 1,
                ).opacity(opacity: .3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(language.tipAmount),
                  Text(
                    receipt.tipAmount.validate().toString(),
                    style: boldTextStyle(),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildImagePreview(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(
          '$BASE_URL/${receipt.image}',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _entertainedPersonsWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          language.entertainedPersons,
          style: boldTextStyle(),
        ),
        8.height,
        for (String person in receipt.entertainedPersons) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  person,
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
        ]
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
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headingWidget(context),
                  16.height,
                  _amountWidget(context),
                  16.height,
                  _entertainedPersonsWidget(context)
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
              onTap: () {},
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
