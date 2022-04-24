import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nutrimiski/domain/service/child_service.dart';
import 'package:mobile_nutrimiski/domain/service/parent_service.dart';
import 'package:mobile_nutrimiski/model/entitie/category_ingredient.dart';
import 'package:mobile_nutrimiski/model/entitie/child_history.dart';
import 'package:mobile_nutrimiski/model/entitie/nutritionist.dart';
import 'package:provider/provider.dart';

import '../model/entitie/child.dart';

class ChildPresenter extends ChangeNotifier {

  final ParentService _parentService = ParentService();

  final ChildService _childService = ChildService();

  late Child selectedChild;

  late int selectedIndex;

  late List<Child> children = [];

  final List<CategoryIngredient> _preferences = [];

  late List<ChildHistory> _selectedChildWeekHistory = [];

  late List<ChildHistory> _selectedChildMonthHistory = [];

  final DateTime endDate = DateTime.now();

  late DateTime startWeekDate = DateTime.now();

  late DateTime startMonthDate = DateTime.now();

  late double newHeight = 0.0;

  late double newWeight = 0.0;

  late double newImc = 0.0;

  late Nutritionist _nutritionist;

  int _selectedChart = 1;

  int getSelectedChart(){
    return _selectedChart;
  }

  setSelectedChart(int newValue){
    _selectedChart = newValue;
    notifyListeners();
  }

  List<ChildHistory> getWeekHistory(){
    return _selectedChildWeekHistory;
  }

  List<ChildHistory> getMothHistory(){
    return _selectedChildMonthHistory;
  }

  int _historyReady = 0;
  bool _loader = false;
  bool childrenReady = false;

  String getNutritionistDni(){
    return _nutritionist.dni!;
  }

  int getHistoryReady(){
    return _historyReady;
  }

  setHistoryReady(int newValue){
    _historyReady = newValue;
    notifyListeners();
  }

  Nutritionist getParentNutritionist(){
    return _nutritionist;
  }

  setNutritionistDni(String dni){
    _nutritionist.dni = dni;
  }

  Future<void> getNutritionist() async {
    await _parentService.getActiveNutritionist().then((value){
      _nutritionist = value;
    });
  }

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

  localChildUpdate(){
    selectedChild.imc = newImc;
    children[selectedIndex].imc = newImc;
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

    await _childService.deleteChild(context, childId).whenComplete((){
      Provider.of<ChildPresenter>(context, listen: false).children.removeWhere((child) => child.childId == childId);
      return true;
    });

    return false;

  }

  Future<bool> updateChild() async {

    newImc = newWeight/pow((newHeight/100), 2);
    return await _childService.updateChild(selectedChild.childId!, newHeight, newWeight, newImc);
  }


  Future<void> getChildHistory() async {

    startWeekDate = endDate.subtract(const Duration(days: 6));

    startMonthDate = endDate.subtract(const Duration(days: 29));

    await _childService.getChildHistory(selectedChild.childId!, DateFormat('yyyy-MM-dd').format(startWeekDate), DateFormat('yyyy-MM-dd').format(endDate)).then((value){
      _selectedChildWeekHistory = value;
      _historyReady++;
      notifyListeners();
    });

    await _childService.getChildHistory(selectedChild.childId!, DateFormat('yyyy-MM-dd').format(startMonthDate), DateFormat('yyyy-MM-dd').format(endDate)).then((value){
      _selectedChildMonthHistory = value;
      _historyReady++;
      notifyListeners();
    });
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