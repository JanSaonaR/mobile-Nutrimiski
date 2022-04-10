
import 'package:mobile_nutrimiski/model/entitie/user_session.dart';

String getUserName(){
  String userName = "";
  if(UserSession().getFirstName().contains(" ")){
    List<String> userFirstName = UserSession().getFirstName().split(" ");
    userName = userName + userFirstName[0];
  }
  else{
    userName = userName + UserSession().getFirstName();
  }

  if(UserSession().getLastName().contains(" ")){
    List<String> userLastName = UserSession().getLastName().split(" ");
    userName = userName + " " + userLastName[0];
  }
  else{
    userName = userName + " " + UserSession().getLastName();
  }
  return userName;
}

bool isParent(){
  return UserSession().getRol() == "P";
}