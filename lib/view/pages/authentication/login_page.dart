import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/presenter/user_presenter.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../model/dto/user_login_dto.dart';
import '../../widgets/common/button.dart';
import '../logged_in_view/app_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback goBack;
  const LoginPage({required this.goBack, Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  UserLoginDto _toSend = UserLoginDto("", "");

  final _formKey = GlobalKey<FormState>();

  late bool loader;
  bool isHiddenPassword = true;

  void _saveForm(Function open) {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

    }
  }

  void _togglePassword() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Material(
        color: backgroundColor,
        child: Stack(
          children: [
            Positioned(
              top: 80, left: 25,
              child: InkWell(
                onTap: widget.goBack,
                child: const CircleAvatar(
                  radius: 25,
                  backgroundColor: primaryColor,
                  child: Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 30,),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 150, bottom: 50, left: 30, right: 30),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: screenSize.height/50),
                        const Text('LOGO', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                        SizedBox(height: screenSize.height/5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            color: textFieldColor
                          ),
                          width: 300,
                          child: TextFormField(
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                height: 0.5
                            ),
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.3)),
                              hintText: 'example@example.com',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Ingrese un correo";
                              }
                              // if (!value.contains("@")) {
                              //   return "Ingrese un correo valido";
                              // }
                            },
                            onSaved: (value) {
                              _toSend = UserLoginDto(value!, _toSend.password);
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              color: textFieldColor
                          ),
                          width: 300,
                          child: TextFormField(
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                height: 0.5,
                            ),
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                suffixIcon: InkWell(
                                  child: isHiddenPassword == false
                                      ? const Icon(Icons.visibility, color: Colors.white,)
                                      : const Icon(Icons.visibility_off, color: Colors.white),
                                  onTap: _togglePassword,
                                )),
                            onSaved: (value) {
                              _toSend = UserLoginDto(_toSend.email, value!);
                            },
                            obscureText: isHiddenPassword,
                            textInputAction: TextInputAction.done,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Ingrese una contraseña";
                              }
                            },
                          ),
                        ),
                        SizedBox(height: screenSize.height/20),
                        const Text('Olvidé mi contraseña', style: TextStyle(color: specialTextColor, fontSize: 12),),
                        SizedBox(height: screenSize.height/20),
                        Provider.of<UserPresenter>(context).getLoader() ?
                        const SizedBox(
                          width: 50,
                          child: LinearProgressIndicator(color: Colors.white,),
                        ): Button(
                          text: "INICIAR SESIÓN",
                          color: secondaryColor,
                          press: () {
                            Provider.of<UserPresenter>(context, listen: false).setLoader(true);
                            _formKey.currentState!.save();
                            Provider.of<UserPresenter>(context, listen: false).loginUser(_toSend).then((value){
                              if(value){
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        duration: const Duration(milliseconds: 200),
                                        reverseDuration: const Duration(milliseconds: 200),
                                        type: PageTransitionType.rightToLeft,
                                        child: const AppPage()
                                    )
                                );
                                Provider.of<UserPresenter>(context, listen: false).setLoader(true);
                              }
                              else{
                                Provider.of<UserPresenter>(context, listen: false).setLoader(true);
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}