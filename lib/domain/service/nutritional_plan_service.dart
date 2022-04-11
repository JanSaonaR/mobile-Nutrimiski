import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';
import 'package:provider/provider.dart';

import '../../model/entitie/user_session.dart';
import '../../presenter/child_register_presenter.dart';

class NutritionalPlanService {
  NutritionalPlanService();

  Future<bool> createNutritionalPlan(BuildContext context) async {
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    var uri = baseUrl + nutritionalPlan;

    Response response = await dio.post(uri,
        queryParameters: {
          'childId': Provider.of<ChildRegisterPresenter>(context, listen: false)
              .getRegisteredChildId(),
        });

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
  
}