import 'package:dio/dio.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';

import '../../model/dto/user_login_dto.dart';
import '../../model/entitie/user_session.dart';

class UserService{

  UserService();

  Future<int> loginUser(UserLoginDto user) async {

    final dio = Dio();

    var uri = baseUrl + userEndpoint + userLogin;

    var response = await dio.post(uri, data: user.toJson());

    int errorCode = response.data['errorCode'];

    if (response.statusCode == 200 && errorCode == 0) {

      if(response.data['data']['profile']['user']['rol'] == 'P'){
        UserSession().userLogin(response.data['data']['profile']['parentId'], response.headers.value('Token')!, response.data['data']['profile']['user']['firstName'],
            response.data['data']['profile']['user']['lastName'], response.data['data']['profile']['user']['email'], response.data['data']['profile']['user']['rol']);
      }
      else{
        UserSession().userLogin(response.data['data']['profile']['nutritionistId'], response.headers.value('Token')!, response.data['data']['profile']['user']['firstName'],
            response.data['data']['profile']['user']['lastName'], response.data['data']['profile']['user']['email'], response.data['data']['profile']['user']['rol']);
      }

      if(response.data['data']['profile']['user']['picture'] != null){
        UserSession().setUserImage(response.data['data']['profile']['user']['picture']['url']);
      }

    }

    return errorCode;
  }

}