import 'dart:convert';

import 'package:mobile_app/models/config_model.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/network/network_utils.dart';
import 'package:nb_utils/nb_utils.dart';

Future<ConfigModel?> getConfig() async {
  final response =
      await requestWithToken('/config', method: HttpMethodType.GET);

  final jsonResponse = jsonDecode(response.body);

  HttpResponseModel httpResponse = HttpResponseModel.fromJson(jsonResponse);
  if (httpResponse.status != 1) {
    toast(httpResponse.msg);
    return null;
  }
  ConfigModel? data = ConfigModel.fromJson(httpResponse.data);
  return data;
}
