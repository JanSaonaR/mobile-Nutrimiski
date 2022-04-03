import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobile_nutrimiski/model/dto/parent_register_dto.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';


class NutritionistService{

  NutritionistService();

  Future<bool> registerNutritionist(Map<String, dynamic> nutritionist, File file) async {

    final dio = Dio();

    // FormData formData = FormData.fromMap(nutritionist);
    //
    // String fileName = file.path.split('/').last;
    //
    // formData.files.add(MapEntry('profilePic', await MultipartFile.fromFile(file.path, filename:fileName)));

    var uri = baseUrl + userEndpoint + nutritionistRegister;

    var response = await dio.post(uri, data: nutritionist);

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

}