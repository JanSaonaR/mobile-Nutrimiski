import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/presenter/child_presenter.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';
import 'package:provider/provider.dart';

import '../../model/entitie/user_session.dart';
import '../../presenter/child_register_presenter.dart';

class ChildService {

  ChildService();

  Future<bool> savePreferences(BuildContext context) async {
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    var uri = baseUrl + childPreferencesEndpoint + childPreferencesSave;

    //TODO: CREATE INGREDIENT ENTITY, SERVICE, PRESENTER

    // var response = await dio.post(uri, queryParameters: {
    //   'childId': Provider.of<ChildRegisterPresenter>(context, listen: false).getRegisteredChildId(),
    // }, data: );

    return true;

  }

  Future<bool> deleteChild(BuildContext context, int childId) async {

    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    var uri = baseUrl + childEndpoint;

    var response = await dio.delete(uri, queryParameters: {
      'childId': childId
    });

    if(response.statusCode == 200) {
      return true;
    }

    return false;
  }

}