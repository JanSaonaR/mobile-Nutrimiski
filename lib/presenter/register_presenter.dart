
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/domain/service/nutritionist_service.dart';
import 'package:mobile_nutrimiski/domain/service/parent_service.dart';
import 'package:mobile_nutrimiski/model/dto/parent_register_dto.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../model/dto/nutritionist_register_dto.dart';
import '../model/dto/register_dto.dart';

class RegisterPresenter extends ChangeNotifier{

  AssetImage _image = const AssetImage("assets/images/parent.jpg");
  final Map<String, dynamic> _parentRegisterDto = ParentRegisterDto("", "", "", "", "", "", "", "M").toJson();
  final ParentRegisterDto parentRegisterDto = ParentRegisterDto("", "", "", "", "", "", "", "");
  final Map<String, dynamic> _nutritionistRegisterDto = NutritionistRegisterDto("", "", "", "", "", "", "", "M", "").toJson();
  final ParentService _parentService = ParentService();
  final NutritionistService _nutritionistService = NutritionistService();
  late File _file = File("");
  bool _loader = false;
  bool _validateImage = true;

  int _rol = 0;

  Future<void> initUser(BuildContext context) async {
    var client = StreamChat.of(context).client;
    await client.connectUser(
      User(
          id: _parentRegisterDto['dni'],
          extraData: {
            "name" : _parentRegisterDto['firstName']
          }
      ),
      client.devToken(_parentRegisterDto['dni']).rawValue,);
  }

  bool getValidateImage(){
    return _validateImage;
  }

  getImage(){
    return _image;
  }

  getRol(){
    return _rol;
  }

  setFile(File file){
    _file = file;
  }

  getLoader(){
    return _loader;
  }

  setLoader(bool newState){
    _loader = newState;
    notifyListeners();
  }

  validateImage(bool newState){
    _validateImage = newState;
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
      Map<String, dynamic> registerDto = RegisterDto(_parentRegisterDto).toJson();
      if(_file.path != ""){
        return await _parentService.registerParent(_parentRegisterDto, _file);
      }
      else{
        return await _parentService.registerParent(_parentRegisterDto, null);
      }
    }
    else{
      if(_file.path != ""){
        return await _nutritionistService.registerNutritionist(_nutritionistRegisterDto, _file);
      }
      else{
        return await _nutritionistService.registerNutritionist(_nutritionistRegisterDto, null);
      }
    }
  }

}