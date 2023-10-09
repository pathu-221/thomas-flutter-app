import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/network/rest_apis/receipts.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class MyReceiptsScreen extends StatelessWidget {
  const MyReceiptsScreen({super.key});

  void loadMyReceipts() async {
    HttpResponseModel response = await getMyReceipts();
    toast(response.msg);
  }

  @override
  Widget build(BuildContext context) {
    loadMyReceipts();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          language.myReceipts,
          style: primaryTextStyle(size: 18, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
    );
  }
}
