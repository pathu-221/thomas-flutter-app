import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/config_model.dart';
import 'package:mobile_app/models/receipt_model.dart';
import 'package:mobile_app/network/rest_apis/config_apis.dart';
import 'package:mobile_app/network/rest_apis/receipts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mobile_app/screens/entertainment_receipt/enertainment_receipt_view.dart';
import 'package:mobile_app/screens/main_menu/upload_receipt/entertainment_receipt_screen.dart';
import 'package:mobile_app/screens/main_menu/upload_receipt/self_receipt_reason_screen.dart';
import 'package:mobile_app/screens/self_receipt_reason/self_receipt_reason_view.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class MyReceiptsScreen extends StatefulWidget {
  const MyReceiptsScreen({super.key});

  @override
  State<MyReceiptsScreen> createState() => _MyReceiptsScreenState();
}

class _MyReceiptsScreenState extends State<MyReceiptsScreen> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  ConfigModel? config;
  bool? isSignaturExist;

  @override
  void initState() {
    super.initState();
    loadConfig();
  }

  Future<List<ReceiptModel>?> loadMyReceipts() async {
    return getMyReceipts();
  }

  void loadConfig() async {
    ConfigModel? data = await getConfig();
    if (data != null) {
      setState(() {
        config = data;
      });
    }
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
          onTap: () {
            if (item.entertainmentReceiptId == null &&
                item.selfReceiptId != null) {
              SelfReceiptReasonView(
                receipt: item.selfReceipt!,
              ).launch(context);
            } else if (item.selfReceiptId == null &&
                item.entertainmentReceiptId != null) {
              EntertainmentReceiptView(
                receipt: item.entertainmentReceipt!,
              ).launch(context);
            }
          },
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

  Widget _noDataWidge() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.close_rounded,
            size: 80,
          ),
          16.height,
          Text(
            language.lblNoReceipts.validate(),
            style: secondaryTextStyle(size: 18),
          )
        ],
      ),
    );
  }

  Widget _buildStickyAlertWidget(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: BoxDecoration(
        color: dangerColor.withOpacity(0.2),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${language.missing} ${!config!.addressExist! ? language.address : ""} ${!config!.signatureExist! ? "and ${language.signature}" : ""}",
            style: boldTextStyle(color: dangerColor),
          ),
          // 8.height,
          Text(
            language.missingSubtitle,
            style: secondaryTextStyle(color: dangerColor),
          )
        ],
      ),
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
      body: Column(
        children: [
          if (config != null &&
              (!config!.addressExist! || !config!.signatureExist!))
            _buildStickyAlertWidget(context),
          Expanded(
            child: FutureBuilder<List<ReceiptModel>?>(
              future: loadMyReceipts(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                } else if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.isNotEmpty) {
                  return _buildReceiptsWidget(snapshot.data!);
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return _noDataWidge();
                } else if (snapshot.hasError) {
                  return _noDataWidge();
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        openCloseDial: isDialOpen,
        backgroundColor: primaryColor,
        activeChild: const Icon(
          Icons.close,
          color: Colors.white,
        ),
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
              const EntertainmentReceiptScreen().launch(context).then((value) {
                setState(() {
                  loadMyReceipts();
                });
              });
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
              const SelfReceiptReasonScreen().launch(context).then((value) {
                setState(() {
                  loadMyReceipts();
                });
              });
            },
          ),
        ],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
