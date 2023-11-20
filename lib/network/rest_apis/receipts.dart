import 'dart:convert';

import 'package:mobile_app/models/receipt_model.dart';
import 'package:mobile_app/network/network_utils.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:nb_utils/nb_utils.dart';

Future<List<ReceiptModel>?> getMyReceipts() async {
  final response =
      await requestWithToken('/receipts', method: HttpMethodType.GET);

  final jsonResponse = jsonDecode(response.body);

  HttpResponseModel<List<dynamic>> httpResponse =
      HttpResponseModel.fromJson(jsonResponse);
  if (httpResponse.status != 1) {
    toast(httpResponse.msg);
    return null;
  }

  List<ReceiptModel> data = httpResponse.data!.map((item) {
    return ReceiptModel.fromJson(item);
  }).toList();

  return data;
}

Future<HttpResponseModel?> getEntertainmentReceiptByMail(
    String receiptId) async {
  final response = await requestWithToken(
      '/entertainment-receipt/send-mail/$receiptId',
      method: HttpMethodType.GET);

  final jsonResponse = jsonDecode(response.body);

  HttpResponseModel httpResponse = HttpResponseModel.fromJson(jsonResponse);
  if (httpResponse.status != 1) {
    toast(httpResponse.msg);
    return null;
  }
  return httpResponse;
}

Future<HttpResponseModel?> getSelfReceiptByMail(String receiptId) async {
  final response = await requestWithToken('/self-receipt/send-mail/$receiptId',
      method: HttpMethodType.GET);

  final jsonResponse = jsonDecode(response.body);

  HttpResponseModel httpResponse = HttpResponseModel.fromJson(jsonResponse);
  if (httpResponse.status != 1) {
    toast(httpResponse.msg);
    return null;
  }
  return httpResponse;
}
