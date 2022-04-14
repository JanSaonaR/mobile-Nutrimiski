import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/domain/service/meal_service.dart';

import '../model/entitie/meal.dart';

class MealPresenter extends ChangeNotifier {

  final MealService _mealService = MealService();

  List<Meal> mealsByDay = [];

  List<Meal> mealsBetweenDates = [];

  late Meal selectedMeal;

  getMealsByDayList(){
    return mealsByDay;
  }

  bool mealsByDayReady = false;

  bool mealsBetweenDatesReady = false;

  Future<bool> getMealsByDay(BuildContext context, String date) async {

    mealsByDay.clear();

    await _mealService.getMealsByDay(context, date).then((value){
      mealsByDay = value;

      if(mealsByDay.isNotEmpty) {
        mealsByDayReady = true;
      }

    });

    return mealsByDayReady;
  }

  Future<bool> getMealsBetweenDates(BuildContext context, String startDate, String endDate) async {

    mealsBetweenDates.clear();

    await _mealService.getMealsBetweenDates(context, startDate, endDate).then((value){
      mealsBetweenDates = value;

      if(mealsBetweenDates.isNotEmpty) {
        mealsBetweenDatesReady = true;
      }

    });

    return mealsBetweenDatesReady;
  }

}