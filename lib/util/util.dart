
import 'dart:ui';

import 'package:flutter/material.dart';
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


String getChannelName(){
  String chatName = UserSession().getLastName() + ', ';

  if(UserSession().getFirstName().contains(" ")){
    List<String> userFirstName = UserSession().getFirstName().split(" ");
    chatName = chatName + userFirstName[0];
  }
  else{
    chatName = chatName + UserSession().getFirstName();
  }

  return chatName;
}

bool isParent(){
  return UserSession().getRol() == "P";
}

String setPatientStateName(double imc){
  if (imc >= 30.0) {
    return "OBESIDAD";
  }
  if (imc < 30.0 && imc >= 25.0) {
    return "SOBREPESO";
  }
  if (imc < 24.9 && imc >= 18.5) {
    return "NORMAL";
  }
  if (imc < 18.5) {
    return "BAJO PESO";
  }
  return "NORMAL";
}

Color setPatientStateColor(double imc){
  if (imc >= 30.0) {
    return Colors.red;
  }
  if (imc < 30.0 && imc >= 25.0) {
    return Colors.redAccent;
  }
  if (imc < 24.9 && imc >= 18.5) {
    return Colors.greenAccent;
  }
  if (imc < 18.5) {
    return Colors.yellow;
  }

  return Colors.greenAccent;
}