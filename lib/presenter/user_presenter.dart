import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/domain/service/user_service.dart';
import 'package:mobile_nutrimiski/model/dto/user_login_dto.dart';

class UserPresenter extends ChangeNotifier {

  final UserService _userService = UserService();
  bool _loader = false;
  String _messageError = "";
  bool _showMessageError = false;

  bool getLoader(){
    return _loader;
  }

  bool getShowMessageError(){
    return _showMessageError;
  }

  String getMessageError(){
    return _messageError;
  }

  setLoader(bool newState){
    _loader = newState;
    notifyListeners();
  }

  setMessageError(int error){
    switch(error){
      case 1:
        _messageError = "Usuario no registrado.";
        break;
      case 2:
        _messageError = "Contraseña incorrecta.";
        break;
    }
    _showMessageError = true;
    notifyListeners();
  }

  Future<int> loginUser(UserLoginDto loginUserDto) async {
    return await _userService.loginUser(loginUserDto);
  }

}