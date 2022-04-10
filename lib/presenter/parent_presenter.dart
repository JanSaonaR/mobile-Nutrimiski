import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/domain/service/nutritionist_service.dart';

import '../model/entitie/parent.dart';

class ParentPresenter extends ChangeNotifier {

  final NutritionistService _nutritionistService = NutritionistService();

  //final ChildService _childService = ChildService();

  late Parent selectedParent;

  late List<Parent> parents = [];

  bool _loader = false;
  bool parentsReady = false;

  getLoader(){
    return _loader;
  }

  setLoader(bool newState){
    _loader = newState;
    notifyListeners();
  }

  Future<bool> getParents() async{
    await _nutritionistService.getParentsByNutritionist().then((value){
      parents = value;
      if(parents.isNotEmpty){
        parentsReady = true;
      }
    });
    return parentsReady;
  }

  // Future<bool> deleteChild(BuildContext context, int childId) async {
  //
  //   await _childService.deleteChild(context, childId).then((value){
  //     if(value == true) {
  //       Provider.of<ChildPresenter>(context, listen: false).children.removeWhere((child) => child.childId == childId);
  //       return true;
  //     }
  //   });
  //
  //   return false;
  //
  // }

}