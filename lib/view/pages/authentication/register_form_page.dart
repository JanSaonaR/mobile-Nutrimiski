import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/util/colors.dart';

import '../../../model/dto/user_login_dto.dart';
import '../../widgets/common/button.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {

  final _formKey = GlobalKey<FormState>();

  late bool loader;
  bool isHiddenPassword = false;

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
                onTap: () {
                  Navigator.pop(context);
                },
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
                        Button(
                          text: "CREAR CUENTA",
                          color: secondaryColor,
                          press: () {},
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