import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:mobile_nutrimiski/view/pages/authentication/select_rol_page.dart';


class GoToPage {
  static const int selectRol = 0;
  static const int registerForm = 1;
}


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final PageController _pageController = PageController(initialPage: GoToPage.selectRol);

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
        backgroundColor: backgroundColor,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            SelectRolPage(goToRegisterForm: () {})
          ],
        )
    );
  }
}