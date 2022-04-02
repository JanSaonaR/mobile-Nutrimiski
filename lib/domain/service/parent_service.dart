
import 'package:dio/dio.dart';
import 'package:mobile_nutrimiski/model/dto/parent_register_dto.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';


class ParentService{

  ParentService();

  Future<bool> registerParent(Map<dynamic, dynamic> parent) async {

    final dio = Dio();

    var uri = baseUrl + userEndpoint + parentRegister;

    var response = await dio.post(uri, data: parent);

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

}