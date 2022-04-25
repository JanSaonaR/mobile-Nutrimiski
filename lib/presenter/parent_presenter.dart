import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/domain/service/nutritionist_service.dart';
import 'package:mobile_nutrimiski/domain/service/parent_service.dart';
import 'package:mobile_nutrimiski/model/entitie/child.dart';

import '../model/entitie/parent.dart';

class ParentPresenter extends ChangeNotifier {

  final NutritionistService _nutritionistService = NutritionistService();

  final ParentService _parentService = ParentService();

  //final ChildService _childService = ChildService();

  late List<Child> _parentChildren = [];

  getParentChildren(){
    return _parentChildren;
  }

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

  Future<List<Child>> getChildrenFromParentId(BuildContext context) async {

    _parentChildren.clear();

    await _parentService.getChildrenFromParentId(context).then((value){
      _parentChildren = value;
      return _parentChildren;
    });

    return [];
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