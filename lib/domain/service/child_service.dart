import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/presenter/child_presenter.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';
import 'package:provider/provider.dart';

import '../../model/entitie/category_ingredient.dart';
import '../../model/entitie/user_session.dart';
import '../../presenter/child_register_presenter.dart';

class ChildService {

  ChildService();

  Future<bool> saveRegisteredChildPreferences(BuildContext context, List<CategoryIngredient> preferences) async {
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    bool responseController = false;

    var uri = baseUrl + childPreferencesEndpoint + childPreferencesSave;

    Response response = await dio.post(uri, queryParameters: {
      'childId': Provider.of<ChildRegisterPresenter>(context, listen: false).getRegisteredChildId(),
    }, data: jsonEncode(preferences));

    if(response.statusCode == 201) {
      responseController = true;

      return responseController;
    }

    return responseController;
  }

  Future<bool> updateChildPreferences(BuildContext context, List<CategoryIngredient> preferences) async {
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    bool responseController = false;

    var uri = baseUrl + childPreferencesEndpoint + childPreferencesSave;

    Response response = await dio.post(uri, queryParameters: {
      'childId': Provider.of<ChildPresenter>(context, listen: false).selectedChild.childId,
    }, data: jsonEncode(preferences));

    if(response.statusCode == 201) {
      responseController = true;

      return responseController;
    }

    return responseController;
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