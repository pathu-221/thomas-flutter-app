import 'dart:convert';

import 'package:mobile_app/network/network_utils.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:nb_utils/nb_utils.dart';

Future<HttpResponseModel> getMyReceipts() async {
  final response =
      await requestWithToken('/receipts', method: HttpMethodType.GET);

  final jsonResponse = jsonDecode(response.body);

  HttpResponseModel httpResponse = HttpResponseModel.fromJson(jsonResponse);

  return httpResponse;
}
