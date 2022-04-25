import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/presenter/chat_presenter.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../domain/service/nutritional_plan_service.dart';
import 'child_presenter.dart';

class NutritionalPlanPresenter extends ChangeNotifier {

  final NutritionalPlanService _nutritionalPlanService = NutritionalPlanService();

  Future<bool> createNutritionalPlan(BuildContext context) async {

    bool responseController = false;

    await _nutritionalPlanService.createNutritionalPlan(context).then((value){
      if(value) {
        responseController = true;
        Provider.of<ChatPresenter>(context, listen: false).initChannels(Provider.of<ChildPresenter>(context, listen: false).getNutritionistDni(), [], StreamChat.of(context).client);
      }
    });

    if(responseController == true) {
      return true;
    } else {
      return false;
    }
  }

}