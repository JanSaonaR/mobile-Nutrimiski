import 'package:dio/dio.dart';
import 'package:mobile_nutrimiski/model/dto/parent_register_dto.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';


class NutritionistService{

  NutritionistService();

  Future<bool> registerNutritionist(Map<dynamic, dynamic> nutritionist) async {

    final dio = Dio();

    var uri = baseUrl + userEndpoint + nutritionistRegister;

    var response = await dio.post(uri, data: nutritionist);

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

}