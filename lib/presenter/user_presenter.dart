import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/domain/service/user_service.dart';
import 'package:mobile_nutrimiski/model/dto/user_login_dto.dart';

class UserPresenter extends ChangeNotifier {

  final UserService _userService = UserService();
  bool _loader = false;

  getLoader(){
    return _loader;
  }

  setLoader(bool newState){
    _loader = newState;
    notifyListeners();
  }

  Future<bool> loginUser(UserLoginDto loginUserDto) async {
    return await _userService.loginUser(loginUserDto);
  }

}