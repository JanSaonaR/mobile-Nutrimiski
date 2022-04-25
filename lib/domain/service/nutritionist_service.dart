import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mobile_nutrimiski/model/entitie/parent.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';

import '../../model/entitie/user_session.dart';
import 'multipart_register_service.dart';


class NutritionistService{

  NutritionistService();

  Future<bool> registerNutritionist(Map<String, dynamic> nutritionist, File? file) async {

    String dataEncoded = json.encode(nutritionist);

    MultipartField mf = MultipartField(dataEncoded, headers: {
      Headers.contentTypeHeader : "application/json"
    });

    var uri = Uri.parse(baseUrl + userEndpoint + nutritionistRegister);

    late MultipartRequestEx req;

    if(file != null){
      req = MultipartRequestEx('POST', uri)
        ..fields["request"] = mf
        ..files.add(await http.MultipartFile.fromPath('profilePic', file.path, contentType: MediaType('application', 'x-tar')));
    }
    else{
      req = MultipartRequestEx('POST', uri)
        ..fields["request"] = mf;
    }

    var response = await req.send();

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<List<Parent>> getParentsByNutritionist() async{

    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    var uri = baseUrl + nutritionistEndpoint + activeParentsByNutritionist;

    var response = await dio.get(uri, queryParameters: {'nutritionistId' : UserSession().getId()});

    if(response.statusCode == 200) {
      List aux = response.data["data"].map((e) => Parent.fromJson(e)).toList();
      return aux.cast<Parent>();
    }

    return [];
  }

}