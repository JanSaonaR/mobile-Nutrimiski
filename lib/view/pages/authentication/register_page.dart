import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:mobile_nutrimiski/view/pages/authentication/register_form_rol_page.dart';
import 'package:mobile_nutrimiski/view/pages/authentication/register_form_user_page.dart';
import 'package:mobile_nutrimiski/view/pages/authentication/register_success_page.dart';
import 'package:mobile_nutrimiski/view/pages/authentication/select_rol_page.dart';


class GoToPage {
  static const int selectRol = 0;
  static const int userRegisterForm = 1;
  static const int rolRegisterForm = 2;
  static const int registerSuccess = 3;
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

    return Scaffold(
        backgroundColor: backgroundColor,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            SelectRolPage(goToUserRegisterForm: () { _switchPage(GoToPage.userRegisterForm); }),
            UserRegisterFormPage(goToSelectRol: () { _switchPage(GoToPage.selectRol); }, goToRolRegisterForm: () { _switchPage(GoToPage.rolRegisterForm);} ),
            RolRegisterFormPage(goToUserRegisterForm: () { _switchPage(GoToPage.userRegisterForm); }, goToRegisterSuccess: () { _switchPage(GoToPage.registerSuccess); },),
            RegisterSuccessPage(goBack: (){ Navigator.pop(context); })
          ],
        )
    );
  }
}