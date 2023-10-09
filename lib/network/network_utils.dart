import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/utils/configs.dart';
import 'package:mobile_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

Future<Response> httpRequest(
  String endPoint, {
  HttpMethodType method = HttpMethodType.GET,
  Map? request,
  Map<String, String>? headers,
}) async {
  Map<String, String> header = {
    HttpHeaders.contentTypeHeader: "application/json",
  };

  if (headers != null) header.addAll(headers);
  if (await isNetworkAvailable() == false) throw errorInternetNotAvailable;
  Uri url = Uri.parse('$BASE_URL$endPoint');
  Response response;
  switch (method) {
    case HttpMethodType.POST:
      response =
          await http.post(url, body: jsonEncode(request), headers: header);
      break;
    case HttpMethodType.GET:
      response = await http.get(url, headers: header);
      break;
    case HttpMethodType.PUT:
      response =
          await http.put(url, body: jsonEncode(request), headers: header);
      break;
    case HttpMethodType.DELETE:
      response =
          await http.delete(url, body: jsonEncode(request), headers: header);
      break;
    default:
      response = await http.get(url, headers: headers);
  }

  return response;
}

Future<Response> requestWithToken(
  String endPoint, {
  HttpMethodType method = HttpMethodType.GET,
  Map? request,
  Map<String, String>? headers,
}) async {
  String token = getStringAsync(AUTH_TOKEN);

  Map<String, String> header = {
    HttpHeaders.authorizationHeader: "Bearer $token",
  };

  if (headers != null) header.addAll(headers);

  Response response = await httpRequest(endPoint,
      method: method, request: request, headers: header);
  return response;
}

Future<Response> requestWithoutToken(
  String endPoint, {
  HttpMethodType method = HttpMethodType.GET,
  Map? request,
  Map<String, String>? headers,
}) async {
  Response response =
      await httpRequest(endPoint, method: method, request: request);

  return response;
}
