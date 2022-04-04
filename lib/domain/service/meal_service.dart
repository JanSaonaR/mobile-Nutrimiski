import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/model/entitie/meal.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';
import 'package:provider/provider.dart';

import '../../model/entitie/child.dart';
import '../../model/entitie/user_session.dart';
import '../../presenter/child_presenter.dart';

class MealService {

  MealService();

  Future<List<Meal>> getMealsByDay(BuildContext context, String date) async {
    final dio = Dio();

    Child child = Provider.of<ChildPresenter>(context, listen: false).selectedChild;

    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    var uri = baseUrl + mealEndpoint + getMealsByDayEndpoint;

    var response = await dio.get(uri,
      queryParameters: {
        'childId': child.childId,
        'date': date
      }
    );

    if(response.statusCode == 200) {
      List<Meal> mealList = [];

      mealList = response.data.map((e) => Meal.fromJson(e)).toList();

      return mealList;
    }

    return [];

  }

}