import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:mobile_nutrimiski/view/pages/authentication/register_page.dart';
import 'package:page_transition/page_transition.dart';

import '../../widgets/common/button.dart';
import 'login_page.dart';

class GoToPage {
  static const int home = 0;
  static const int login = 1;
  static const int forgotPassword = 2;
}

class AuthenticationPage extends StatefulWidget {
  const   AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  final PageController _pageController = PageController(initialPage: GoToPage.home);

  void _switchPage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_image.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            height: screenSize.height,
            width: screenSize.width,
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(44, 53, 73, 0.8)
              ),
              width: screenSize.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: 75,
                    child: Text('LOGO', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  ),
                  Positioned(
                    top: 300, left: 20, right: 20, bottom: 100,
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Text('BIENVENIDO A', style: TextStyle(color: Colors.white, fontSize: screenSize.width/10, fontWeight: FontWeight.bold),),
                            Text('NUTRIMIKUY', style: TextStyle(color: Colors.white, fontSize: screenSize.width/9, fontWeight: FontWeight.bold),),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: screenSize.width/1.2,
                              child: const Text('Una aplicación donde podrás tener     recomendaciones de alimentos y platos saludables.',
                                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal), textAlign: TextAlign.center,),
                            ),
                            const SizedBox(
                              height: 100.0,
                            ),
                            Button(
                                text: "INICIAR SESIÓN",
                                color: secondaryColor,
                                press: () {
                                  _switchPage(GoToPage.login);
                                }
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Button(
                                text: "REGISTRARSE",
                                color: primaryColor,
                                press: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: const Duration(milliseconds: 200),
                                          reverseDuration: const Duration(milliseconds: 200),
                                          type: PageTransitionType.rightToLeft,
                                          child: const RegisterPage()
                                      )
                                  );
                                }
                            ),
                            // const RegisterButton(),
                          ],
                        ),
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ),
          LoginPage(
            goBack: () {
              _switchPage(GoToPage.home);
            },
          )
        ],
      )
    );
  }
}