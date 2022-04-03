import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/domain/service/parent_service.dart';

import '../model/entitie/child.dart';

class ChildPresenter extends ChangeNotifier {

  final ParentService _parentService = ParentService();

  late Child selectedChild;

  late List<Child> children = [];
  bool _loader = false;
  bool childrenReady = false;

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

}