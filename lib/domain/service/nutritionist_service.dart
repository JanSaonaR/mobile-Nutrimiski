import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';

import 'multipart_register_service.dart';


class NutritionistService{

  NutritionistService();

  Future<bool> registerNutritionist(Map<String, dynamic> nutritionist, File file) async {

    String dataEncoded = json.encode(nutritionist);

    MultipartField mf = MultipartField(dataEncoded, headers: {
      Headers.contentTypeHeader : "application/json"
    });

    var uri = Uri.parse(baseUrl + userEndpoint + nutritionistRegister);
    var req = MultipartRequestEx('POST', uri)
      ..fields["request"] = mf
      ..files.add(await http.MultipartFile.fromPath('profilePic', file.path, contentType: MediaType('application', 'x-tar')));

    var response = await req.send();

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

}