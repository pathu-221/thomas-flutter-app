import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/models/user_model.dart';
import 'package:mobile_app/network/network_utils.dart';
import 'package:mobile_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

Future<UserDataModel?> register(Map requestBody) async {
  Response response = await requestWithoutToken('/auth/register',
      method: HttpMethodType.POST, request: requestBody);

  final jsonResponse = jsonDecode(response.body);

  HttpResponseModel responseData = HttpResponseModel.fromJson(jsonResponse);

  if (responseData.status != 1) {
    toast(responseData.msg);
    return null;
  }

  UserDataModel data = UserDataModel.fromJson(responseData.data);

  return data;
}

Future<UserDataModel?> login(Map requestBody) async {
  Response response = await requestWithoutToken('/auth/login',
      method: HttpMethodType.POST, request: requestBody);

  final jsonResponse = jsonDecode(response.body);

  HttpResponseModel responseData = HttpResponseModel.fromJson(jsonResponse);

  if (responseData.status != 1) {
    toast(responseData.msg);
    return null;
  }

  String token = responseData.data['token'];

  setValue(AUTH_TOKEN, token);

  UserDataModel data = UserDataModel.fromJson(responseData.data['user']);

  return data;
}

Future logout() async {
  appStore.setIsLoggedIn(false);
  appStore.setUserFirstName('');
  appStore.setUserLastName('');
  appStore.setUserEmail('');
  setValue(AUTH_TOKEN, '');
}

Future<UserDataModel?> authenticate() async {
  Response? response =
      await requestWithToken('/auth', method: HttpMethodType.GET);

  final jsonResponse = jsonDecode(response.body);

  HttpResponseModel responseData = HttpResponseModel.fromJson(jsonResponse);

  if (responseData.status == 1) {
    UserDataModel data = UserDataModel.fromJson(responseData.data);
    return data;
  }
  return null;
}

Future<HttpResponseModel?> deleteProfile() async {
  Response? response =
      await requestWithToken('/user', method: HttpMethodType.DELETE);

  final jsonResponse = jsonDecode(response.body);

  HttpResponseModel responseData = HttpResponseModel.fromJson(jsonResponse);

  if (responseData.status != 1) {
    toast(responseData.msg);
    return null;
  }

  return responseData;
}
