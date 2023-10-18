import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/models/receipt_model.dart';
import 'package:mobile_app/network/rest_apis/receipts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mobile_app/screens/main_menu/upload_receipt/entertainment_receipt_screen.dart';
import 'package:mobile_app/screens/main_menu/upload_receipt/self_receipt_reason_screen.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class MyReceiptsScreen extends StatefulWidget {
  const MyReceiptsScreen({super.key});

  @override
  State<MyReceiptsScreen> createState() => _MyReceiptsScreenState();
}

class _MyReceiptsScreenState extends State<MyReceiptsScreen> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  Future<List<ReceiptModel>?> loadMyReceipts() async {
    return getMyReceipts();
  }

  Widget _buildReceiptsWidget(List<ReceiptModel> receipts) {
    return ListView.separated(
      itemCount: receipts.length,
      itemBuilder: (context, index) {
        ReceiptModel item = receipts[index];
        String type = item.entertainmentReceiptId == null
            ? language.selfReceiptReason
            : language.entertainmentReceipt;
        String formattedDate =
            DateFormat('dd-MMM-yyyy', 'en_US').format(item.createdAt);
        return SettingItemWidget(
          onTap: () {},
          title: item.entertainmentReceiptId == null
              ? item.selfReceipt!.purpose.validate()
              : item.entertainmentReceipt!.occasion.validate(),
          subTitle: '$type | $formattedDate',
          leading: const Icon(Icons.receipt_long_outlined),
          trailing: const Icon(Icons.chevron_right_sharp),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: context.cardColor,
          indent: 0,
          height: 1,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          language.myReceipts,
          style: primaryTextStyle(size: 18, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder<List<ReceiptModel>?>(
        future: loadMyReceipts(),
        builder: ((context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return _buildReceiptsWidget(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        }),
      ),
      floatingActionButton: SpeedDial(
        openCloseDial: isDialOpen,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        animatedIcon: isDialOpen.value
            ? AnimatedIcons.menu_close
            : AnimatedIcons.add_event,
        animatedIconTheme: const IconThemeData(color: Colors.white),
        overlayColor: Colors.black,
        overlayOpacity: 0.6,
        children: [
          SpeedDialChild(
            child: const Icon(
              Icons.receipt_long_outlined,
              color: Colors.white,
            ),
            backgroundColor: primaryColor,
            label: language.entertainmentReceipt,
            onTap: () {
              const EntertainmentReceiptScreen().launch(context);
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.receipt_rounded,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
            label: language.selfReceiptReason,
            onTap: () {
              const SelfReceiptReasonScreen().launch(context);
            },
          ),
        ],
      ),
    );
  }
}
