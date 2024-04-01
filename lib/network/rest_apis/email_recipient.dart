import 'dart:convert';

import 'package:mobile_app/models/email_recipient_model.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/network/network_utils.dart';
import 'package:nb_utils/nb_utils.dart';

Future<List<EmailRecipientModel>?> fetchAllEmailRecipients() async {
  final response =
      await requestWithToken('/email-recipient', method: HttpMethodType.GET);

  final jsonResponse = jsonDecode(response.body);

  HttpResponseModel<List<dynamic>> responseData =
      HttpResponseModel.fromJson(jsonResponse);

  if (responseData.status != 1) {
    toast(responseData.msg);

    return null;
  }

  List<EmailRecipientModel> data =
      responseData.data!.map((e) => EmailRecipientModel.fromJson(e)).toList();
  return data;
}

Future<HttpResponseModel?> addEmailRecipient(
    Map<dynamic, dynamic> requestFields) async {
  final response = await requestWithToken('/email-recipient',
      method: HttpMethodType.POST, request: requestFields);

  HttpResponseModel? responseData =
      HttpResponseModel.fromJson(jsonDecode(response.body));

  return responseData;
}

Future<HttpResponseModel?> deleteEmailRecipient(String recipientId) async {
  final response = await requestWithToken('/email-recipient/$recipientId',
      method: HttpMethodType.DELETE);

  HttpResponseModel? responseData =
      HttpResponseModel.fromJson(jsonDecode(response.body));

  return responseData;
}
