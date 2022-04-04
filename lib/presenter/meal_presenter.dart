import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/domain/service/meal_service.dart';

import '../model/entitie/meal.dart';

class MealPresenter extends ChangeNotifier {

  final MealService _mealService = MealService();

  late List<Meal> mealsByDay = [];

  bool mealsByDayReady = false;

  Future<bool> getMealsByDay(BuildContext context, String date) async {
    await _mealService.getMealsByDay(context, date).then((value){
      mealsByDay = value;

      if(mealsByDay.isNotEmpty) {
        mealsByDayReady = true;
      }

    });

    return mealsByDayReady;
  }

}