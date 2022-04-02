import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nutrimiski/presenter/register_presenter.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:provider/provider.dart';

import '../../widgets/common/button.dart';

class UserRegisterFormPage extends StatefulWidget {
  final VoidCallback goToSelectRol;
  final Function goToRolRegisterForm;
  const UserRegisterFormPage({Key? key, required this.goToSelectRol, required this.goToRolRegisterForm}) : super(key: key);

  @override
  _UserRegisterFormPageState createState() => _UserRegisterFormPageState();
}

class _UserRegisterFormPageState extends State<UserRegisterFormPage> {

  final _formKey = GlobalKey<FormState>();
  final DateTime _startDate = DateTime.now();
  final TextEditingController _birthDayController = TextEditingController();

  late bool loader;
  bool isHiddenPassword = true;

  final ButtonStyle style =
  ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      minimumSize: const Size(100, 40),
      maximumSize: const Size(300, 40),
      primary: secondaryColor,
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      textStyle: const TextStyle(fontSize: 15)
  );

  Future<void> selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              dialogTheme: const DialogTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
              primaryColor: primaryColor,
              colorScheme: const ColorScheme.light(
                  primary: primaryColor),
              buttonTheme: const ButtonThemeData(
                  textTheme: ButtonTextTheme.primary), // This will change to light theme.
            ),
            child: child!,
          );
        },
        locale: const Locale('en'),
        context: context,
        initialDate: _startDate,
        firstDate: DateTime(1930),
        lastDate: DateTime(2025));
    if (picked != null && picked != _startDate) {
      setState(() {
        Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('birthDate', DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(picked));
        _birthDayController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
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
                onTap: widget.goToSelectRol,
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
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: style,
                                onPressed: () {},
                                child: const Text(
                                  'SeleccionarFoto',
                                  style: TextStyle(color: Colors.white),
                                )
                            ),
                            CircleAvatar(
                              backgroundImage: Provider.of<RegisterPresenter>(context).getImage(),
                              radius: 60,
                            )
                          ],
                        ),
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
                              hintText: 'Nombre',
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
                                return "Ingrese un nombre";
                              }
                              // if (!value.contains("@")) {
                              //   return "Ingrese un correo valido";
                              // }
                            },
                            onSaved: (value) {
                              Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('firstName', value!);
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
                              hintText: 'Apellido',
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
                                return "Ingrese un apellido";
                              }
                              // if (!value.contains("@")) {
                              //   return "Ingrese un correo valido";
                              // }
                            },
                            onSaved: (value) {
                              Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('lastName', value!);
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
                              hintText: 'DNI',
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
                                return "Ingrese un DNI";
                              }
                              // if (!value.contains("@")) {
                              //   return "Ingrese un correo valido";
                              // }
                            },
                            onSaved: (value) {
                              Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('dni', value!);
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
                              hintText: 'Sexo',
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
                                return "Ingrese su sexo";
                              }
                              // if (!value.contains("@")) {
                              //   return "Ingrese un correo valido";
                              // }
                            },
                            onSaved: (value) {
                              Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('sex', value!);
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
                          child: TextField(
                            controller: _birthDayController,
                            onTap: () => selectBirthDate(context),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                height: 0.5
                            ),
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.3)),
                              hintText: 'Fecha nacimiento',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height/10,
                        ),
                        Button(
                          text: "CONTINUAR",
                          color: secondaryColor,
                          press: (){
                            final isValid = _formKey.currentState!.validate();
                            if (isValid) {
                              _formKey.currentState!.save();
                              widget.goToRolRegisterForm();
                            }
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