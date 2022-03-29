import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:page_transition/page_transition.dart';

import 'authentication/authentication_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Text('LOGO', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
      splashIconSize: 150,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: primaryColor,
      nextScreen: const AuthenticationPage(),);
  }

}

