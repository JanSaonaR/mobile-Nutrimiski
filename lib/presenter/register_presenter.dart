
import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/domain/service/nutritionist_service.dart';
import 'package:mobile_nutrimiski/domain/service/parent_service.dart';
import 'package:mobile_nutrimiski/model/dto/parent_register_dto.dart';

import '../model/dto/nutritionist_register_dto.dart';

class RegisterPresenter extends ChangeNotifier{

  AssetImage _image = const AssetImage("assets/images/parent.jpg");
  Map<dynamic, dynamic> _parentRegisterDto = ParentRegisterDto("", "", "", "", "", "", "", "").toJson();
  Map<dynamic, dynamic> _nutritionistRegisterDto = NutritionistRegisterDto("", "", "", "", "", "", "", "", "").toJson();
  final ParentService _parentService = ParentService();
  final NutritionistService _nutritionistService = NutritionistService();
  bool _loader = false;

  int _rol = 0;

  getImage(){
    return _image;
  }

  getRol(){
    return _rol;
  }

  getLoader(){
    return _loader;
  }

  setLoader(bool newState){
    _loader = newState;
    notifyListeners();
  }

  setDesireRol(int rol){
    _rol = rol;
    if(rol == 0){
      _image = const AssetImage("assets/images/parent.jpg");
    }
    else{
      _image = const AssetImage("assets/images/nutritionist.jpg");
    }
    notifyListeners();
  }

  setUserRegisterDto(String value, String newValue){
    if(_rol == 0){
      _parentRegisterDto[value] = newValue;
    }
    else{
      _nutritionistRegisterDto[value] = newValue;
    }
  }

  setNutritionistRegisterDto(String value, String newValue){
    _nutritionistRegisterDto[value] = newValue;
  }

  Future<bool> registerUser() async {
    if(_rol == 0){
      return await _parentService.registerParent(_parentRegisterDto);
    }
    else{
      return await _nutritionistService.registerNutritionist(_nutritionistRegisterDto);
    }
  }

}