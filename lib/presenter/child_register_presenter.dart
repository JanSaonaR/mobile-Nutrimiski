import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/model/dto/child_register_dto.dart';

import '../domain/service/parent_service.dart';

class ChildRegisterPresenter extends ChangeNotifier {

  final ParentService _parentService = ParentService();
  bool _loader = false;
  double _height = 0.0, _weight = 0.0;

  late int _registeredChildId;

  final Map<String, dynamic> _childRegisterDto = ChildRegisterDto("", "", "", "", "M", 0.0, 0.0, 0.0).toJson();


  setRegisteredChildId(int id) => _registeredChildId = id;

  getRegisteredChildId() => _registeredChildId;

  getLoader(){
    return _loader;
  }

  setHeight(double height){
    _height = height;
  }

  setWeight(double weight){
    _weight = weight;
  }

  setChildRegisterDto(String value, String newValue){
    _childRegisterDto[value] = newValue;
  }

  setLoader(bool newState){
    _loader = newState;
    notifyListeners();
  }

  Future<bool> registerChild(BuildContext context) async{
    double imc = _weight/pow((_height/100), 2);
    _childRegisterDto['height'] = _height;
    _childRegisterDto['weight'] = _weight;
    _childRegisterDto['imc'] = imc;

    return await _parentService.registerChild(context, _childRegisterDto);
  }

}