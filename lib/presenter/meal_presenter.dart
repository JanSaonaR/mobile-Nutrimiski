import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/domain/service/meal_service.dart';

import '../model/entitie/meal.dart';

class MealPresenter extends ChangeNotifier {

  final MealService _mealService = MealService();

  late List<Meal> mealsByDay = [];

  late List<Meal> mealsBetweenDates = [];

  bool mealsByDayReady = false;

  bool mealsBetweenDatesReady = false;

  Future<bool> getMealsByDay(BuildContext context, String date) async {
    await _mealService.getMealsByDay(context, date).then((value){
      mealsByDay = value;

      if(mealsByDay.isNotEmpty) {
        mealsByDayReady = true;
      }

    });

    return mealsByDayReady;
  }

  Future<bool> getMealsBetweenDates(BuildContext context, String startDate, String endDate) async {
    await _mealService.getMealsBetweenDates(context, startDate, endDate).then((value){
      mealsBetweenDates = value;

      if(mealsBetweenDates.isNotEmpty) {
        mealsBetweenDatesReady = true;
      }

    });

    return mealsBetweenDatesReady;
  }

}