import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:provider/provider.dart';

import '../../../presenter/register_presenter.dart';
import '../../widgets/common/button.dart';

class RolRegisterFormPage extends StatefulWidget {
  final VoidCallback goToUserRegisterForm;
  final Function goToRegisterSuccess;
  const RolRegisterFormPage({Key? key, required this.goToUserRegisterForm, required this.goToRegisterSuccess}) : super(key: key);

  @override
  _RolRegisterFormPageState createState() => _RolRegisterFormPageState();
}

class _RolRegisterFormPageState extends State<RolRegisterFormPage> {

  final _formKey = GlobalKey<FormState>();

  bool isHiddenPassword = true;

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
              top: 40,
              child: SizedBox(
                width: screenSize.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('LOGO', style: TextStyle(color: secondaryColor, fontSize: 30, fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),
            Positioned(
              top: 80, left: 25,
              child: InkWell(
                onTap: widget.goToUserRegisterForm,
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
              padding: const EdgeInsets.only(bottom: 30.0, left: 15.0, right: 15.0),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: screenSize.height/50),
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
                                    hintText: 'Telefono',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Ingrese un telefono";
                                    }
                                    // if (!value.contains("@")) {
                                    //   return "Ingrese un correo valido";
                                    // }
                                  },
                                  onSaved: (value) {
                                    Provider.of<RegisterPresenter>(context, listen: false).parentRegisterDto.phone = value!;
                                    Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('phone', value);
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
                                      height: 0.5
                                  ),
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.3)),
                                    hintText: 'Correo',
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
                                    if (!value.contains("@") || !value.contains(".com")) {
                                      return "Ingrese un correo valido";
                                    }
                                  },
                                  onSaved: (value) {
                                    Provider.of<RegisterPresenter>(context, listen: false).parentRegisterDto.email = value!;
                                    Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('email', value);
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
                                    hintText: 'Contraseña',
                                      hintStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.3)),
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
                                    Provider.of<RegisterPresenter>(context, listen: false).parentRegisterDto.password = value!;
                                    Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('password', value);
                                  },
                                  obscureText: isHiddenPassword,
                                  textInputAction: TextInputAction.done,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Ingrese una contraseña";
                                    }
                                    if (value.length > 16 || value.length < 8) {
                                      return "Debe tener entre 8 a 16 caracteres";
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Visibility(
                                visible: Provider.of<RegisterPresenter>(context).getRol() == 1,
                                child: Container(
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
                                      hintText: 'Colegiatura',
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
                                        return "Ingrese un código de colegiatura";
                                      }
                                      // if (!value.contains("@")) {
                                      //   return "Ingrese un correo valido";
                                      // }
                                    },
                                    onSaved: (value) {
                                      Provider.of<RegisterPresenter>(context, listen: false).setNutritionistRegisterDto('collegiate', value!);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Provider.of<RegisterPresenter>(context).getLoader() ?
                    const SizedBox(
                      width: 50,
                      child: LinearProgressIndicator(color: Colors.white,),
                    )
                        : Button(
                      text: "CREAR CUENTA",
                      color: secondaryColor,
                      press: () {
                        bool validate = _formKey.currentState!.validate();
                        if(validate){
                          Provider.of<RegisterPresenter>(context, listen: false).setLoader(true);
                          _formKey.currentState!.save();
                          Provider.of<RegisterPresenter>(context, listen: false).registerUser().then((value){
                            if(value){
                              Provider.of<RegisterPresenter>(context, listen: false).setLoader(false);
                              widget.goToRegisterSuccess();
                            }
                            else{
                              Provider.of<RegisterPresenter>(context, listen: false).setLoader(false);
                            }
                          });
                        }
                      },
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