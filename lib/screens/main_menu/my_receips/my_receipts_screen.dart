import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/http_response_model.dart';
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

  void loadMyReceipts() async {
    HttpResponseModel response = await getMyReceipts();
    toast(response.msg);
  }

  @override
  Widget build(BuildContext context) {
    // loadMyReceipts();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          language.myReceipts,
          style: primaryTextStyle(size: 18, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
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
