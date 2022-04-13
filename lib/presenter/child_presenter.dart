import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/domain/service/child_service.dart';
import 'package:mobile_nutrimiski/domain/service/parent_service.dart';
import 'package:mobile_nutrimiski/model/entitie/category_ingredient.dart';
import 'package:provider/provider.dart';

import '../model/entitie/child.dart';

class ChildPresenter extends ChangeNotifier {

  final ParentService _parentService = ParentService();

  final ChildService _childService = ChildService();

  late Child selectedChild;

  late List<Child> children = [];

  final List<CategoryIngredient> _preferences = [];

  bool _loader = false;
  bool childrenReady = false;

  addPreferenceToList(CategoryIngredient ingredient) {
    _preferences.add(ingredient);
  }

  removePreferenceFromList(CategoryIngredient ingredient) {
    _preferences.removeWhere((element) =>
      element.ingredientId == ingredient.ingredientId
    );
  }

  getLoader(){
    return _loader;
  }

  setLoader(bool newState){
    _loader = newState;
    notifyListeners();
  }

  Future<bool> getChildren() async{
    await _parentService.getChildrenFromParent().then((value){
      children = value;
      if(children.isNotEmpty){
        childrenReady = true;
      }
    });
    return childrenReady;
  }

  Future<bool> deleteChild(BuildContext context, int childId) async {

    await _childService.deleteChild(context, childId).then((value){
      if(value == true) {
        Provider.of<ChildPresenter>(context, listen: false).children.removeWhere((child) => child.childId == childId);
        return true;
      }
    });

    return false;

  }

  Future<bool> saveRegisteredChildPreferences(BuildContext context) async {

    bool controller = false;

    await _childService.saveRegisteredChildPreferences(context, _preferences).then((value){
      if(value == true) {
        _preferences.clear();
        controller = true;
        return true;
      }
    });

    return controller;
  }

  Future<bool> updateChildPreferences(BuildContext context) async {
    bool controller = false;

    await _childService.updateChildPreferences(context, _preferences).then((value){
      if(value == true) {
        controller == true;
        _preferences.clear();
        return controller;
      }
    });

    return controller;
  }

}