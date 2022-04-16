import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/model/dto/alternative_meal_dto.dart';
import 'package:mobile_nutrimiski/model/dto/replace_meal_dto.dart';
import 'package:mobile_nutrimiski/model/entitie/meal.dart';
import 'package:mobile_nutrimiski/presenter/meal_presenter.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';
import 'package:provider/provider.dart';

import '../../model/entitie/child.dart';
import '../../model/entitie/user_session.dart';
import '../../presenter/child_presenter.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class MealService {

  MealService();

  Future<List<Meal>> getMealsByDayByChild(BuildContext context, String date, int childId) async {
    final dio = Dio();

    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    var uri = baseUrl + mealEndpoint + getMealsByDayEndpoint;

    var response = await dio.get(uri,
        queryParameters: {
          'childId': childId,
          'date': date
        }
    );

    if(response.statusCode == 200) {
      List<Meal> mealList = [];

      for(Map<String, dynamic> element in response.data["data"]) {
        Meal meal = Meal.fromJson(element);

        mealList.add(meal);
      }

      return mealList;
    }

    return [];
  }

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

      for(Map<String, dynamic> element in response.data["data"]) {
        Meal meal = Meal.fromJson(element);

        mealList.add(meal);
      }

      return mealList;
    }

    return [];
  }

  Future<List<Meal>> getMealsBetweenDates(BuildContext context, String startDate, String endDate) async {
    final dio = Dio();

    Child child = Provider.of<ChildPresenter>(context, listen: false).selectedChild;

    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    var uri = baseUrl + mealEndpoint + getMealsBetweenDatesEndpoint;

    var response = await dio.get(uri,
      queryParameters: {
        'childId': child.childId,
        'endDate': endDate,
        'startDate': startDate
      }
    );

    if(response.statusCode == 200) {
      List<Meal> mealList = [];

      for(Map<String, dynamic> element in response.data["data"]) {
        Meal meal = Meal.fromJson(element);

        mealList.add(meal);
      }

      return mealList;
    }

    return [];
  }

  Future<List<Meal>> getAlternativeMeals(BuildContext context) async {

    final dio = Dio();

    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    final meal = Provider.of<MealPresenter>(context, listen: false).selectedMeal;

    AlternativeMealDto sendMealData = AlternativeMealDto(
      calories: meal.totalCalories,
      type: meal.schedule!.toCapitalized()
    );

    var uri = baseUrl + mealEndpoint + getAlternativeMealsEndpoint;

    var response = await dio.post(uri, data: jsonEncode(sendMealData));

    if(response.statusCode == 200) {
      List<Meal> mealList = [];

      for(Map<String, dynamic> element in response.data["data"]) {
        Meal meal = Meal.fromJson(element);

        mealList.add(meal);
      }

      return mealList;
    }

    return [];
  }

  Future<Meal> replaceAlternativeMeal(BuildContext context) async {
    final dio = Dio();

    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    final meal = Provider.of<MealPresenter>(context, listen: false).mealToReplace;

    int selectedMealId = Provider.of<MealPresenter>(context, listen: false).selectedMeal.mealId!;

    ReplaceMealDto sendMealData = ReplaceMealDto(
      carbohydrates: meal.carbohydrates,
      fat: meal.fat,
      gramsPortion: meal.gramsPortion,
      imageUrl: meal.imageUrl,
      ingredients: meal.ingredients,
      mealId: selectedMealId,
      name: meal.name,
      protein: meal.protein,
      totalCalories: meal.totalCalories
    );

    var uri = baseUrl + mealEndpoint + replaceMealEndpoint;

    Response response = await dio.put(uri, data: jsonEncode(sendMealData));

    if(response.statusCode == 200) {
      Meal responseMeal = Meal.fromJson(response.data["data"]);

      return responseMeal;
    }

    return meal;
  }
}