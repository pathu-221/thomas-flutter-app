import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:mobile_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path/path.dart';

Future<String?> uploadFile(File file, String endpoint) async {
  final Uri uri = Uri.parse('$BASE_URL$endpoint');
  final token = getStringAsync(AUTH_TOKEN);

  final request = MultipartRequest('POST', uri);
  request.headers['Authorization'] = 'Bearer $token';

  final fileStream = ByteStream(file.openRead());
  final fileLength = await file.length();

  final multipartFile = MultipartFile(
    'image',
    fileStream,
    fileLength,
    filename: basename(file.path),
  );

  request.files.add(multipartFile);

  try {
    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    final jsonResponse = jsonDecode(responseData);
    final responseParsed = HttpResponseModel.fromJson(jsonResponse);

    if (responseParsed.status != 1) {
      throw ErrorDescription(responseParsed.msg ?? '');
    }

    return responseParsed.data;
  } catch (e) {
    toast('$e');
    return null;
  }
}
