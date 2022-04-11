import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../domain/service/nutritional_plan_service.dart';

class NutritionalPlanPresenter extends ChangeNotifier {

  final NutritionalPlanService _nutritionalPlanService = NutritionalPlanService();

  Future<bool> createNutritionalPlan(BuildContext context) async {

    bool responseController = false;

    await _nutritionalPlanService.createNutritionalPlan(context).then((value){
      if(value == true) {
        responseController = true;
      }
    });

    if(responseController == true) {
      return true;
    } else {
      return false;
    }
  }

}