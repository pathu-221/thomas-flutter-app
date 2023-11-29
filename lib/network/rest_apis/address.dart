import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_app/models/address_model.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/network/network_utils.dart';
import 'package:nb_utils/nb_utils.dart';

Future<AddressModel?> addAddress(Map<dynamic, dynamic> requestFields) async {
  Response response = await requestWithToken('/address',
      method: HttpMethodType.POST, request: requestFields);

  HttpResponseModel responseData =
      HttpResponseModel.fromJson(jsonDecode(response.body));

  if (responseData.status != 1) {
    toast(responseData.msg);
    return null;
  }

  AddressModel? data = AddressModel.fromJson(responseData.data);

  toast(responseData.msg);
  return data;
}
