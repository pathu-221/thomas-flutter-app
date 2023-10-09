import 'dart:convert';

import 'package:mobile_app/network/network_utils.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:nb_utils/nb_utils.dart';

Future<HttpResponseModel> forgotPasswordOtp(Map<String, String> body) async {
  final response = await requestWithoutToken('/reset-password',
      method: HttpMethodType.POST, request: body);

  final jsonResponse = jsonDecode(response.body);

  HttpResponseModel httpResponse = HttpResponseModel.fromJson(jsonResponse);

  return httpResponse;
}

Future<HttpResponseModel> updatePassword(Map<String, dynamic> body) async {
  final response = await requestWithoutToken('/reset-password',
      method: HttpMethodType.PUT, request: body);

  final jsonResponse = jsonDecode(response.body);

  HttpResponseModel httpResponse = HttpResponseModel.fromJson(jsonResponse);

  return httpResponse;
}
