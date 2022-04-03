import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nutrimiski/model/dto/child_register_dto.dart';
import 'package:mobile_nutrimiski/presenter/register_presenter.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:provider/provider.dart';

import '../../../presenter/child_register_presenter.dart';
import '../../../util/styles.dart';
import '../../widgets/common/button.dart';

class ChildRegisterFormPage extends StatefulWidget {
  const ChildRegisterFormPage({Key? key}) : super(key: key);

  @override
  _ChildRegisterFormPageState createState() => _ChildRegisterFormPageState();
}

class _ChildRegisterFormPageState extends State<ChildRegisterFormPage> {

  final _formKey = GlobalKey<FormState>();
  final DateTime _startDate = DateTime.now();
  final TextEditingController _birthDayController = TextEditingController();

  late bool loader;
  bool isHiddenPassword = true;

  String gender = "Hombre";

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
        Provider.of<ChildRegisterPresenter>(context, listen: false).setChildRegisterDto('birthDate', DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(picked));
        _birthDayController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Material(
        color: backgroundColor,
        child: Scaffold(
          body: Stack(
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
                  onTap: (){
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
                margin: const EdgeInsets.only(top: 150, bottom: 30, left: 30, right: 30),
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
                                Provider.of<ChildRegisterPresenter>(context, listen: false).setChildRegisterDto('firstName', value!);
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
                                Provider.of<ChildRegisterPresenter>(context, listen: false).setChildRegisterDto('lastName', value!);
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
                                Provider.of<ChildRegisterPresenter>(context, listen: false).setChildRegisterDto('dni', value!);
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            height: 50,
                            width: 300,
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                color: textFieldColor
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: textFieldColor,
                                value: gender,
                                icon: const Icon(Icons.arrow_forward_ios, size: 14.0, color: Color.fromRGBO(255, 255, 255, 0.3)),
                                style: GoogleFonts.inter(color: Colors.white),
                                onChanged: (String? newValue){
                                  setState((){
                                    gender = newValue!;
                                    if (gender == 'Hombre') {
                                      Provider.of<ChildRegisterPresenter>(context, listen: false).setChildRegisterDto('sex', "H");
                                    } else {
                                      Provider.of<ChildRegisterPresenter>(context, listen: false).setChildRegisterDto('sex', "M");
                                    }
                                  });
                                },
                                items: <String>['Hombre', 'Mujer'].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: const TextStyle(color: Colors.white)),
                                  );
                                }).toList(),
                              ),
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
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    color: textFieldColor
                                ),
                                width: 145,
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      height: 0.5
                                  ),
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.3)),
                                    hintText: 'Altura cm',
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
                                      return "Ingrese la altura del niñ@";
                                    }
                                    // if (!value.contains("@")) {
                                    //   return "Ingrese un correo valido";
                                    // }
                                  },
                                  onSaved: (value) {
                                    Provider.of<ChildRegisterPresenter>(context, listen: false).setHeight(double.parse(value!));
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    color: textFieldColor
                                ),
                                width: 145,
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      height: 0.5
                                  ),
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.3)),
                                    hintText: 'Peso kg',
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
                                      return "Ingrese el peso del niñ@";
                                    }
                                    // if (!value.contains("@")) {
                                    //   return "Ingrese un correo valido";
                                    // }
                                  },
                                  onSaved: (value) {
                                    Provider.of<ChildRegisterPresenter>(context, listen: false).setWeight(double.parse(value!));
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenSize.height/20,
                          ),
                          Provider.of<ChildRegisterPresenter>(context).getLoader() ?
                          const SizedBox(
                            width: 50,
                            child: LinearProgressIndicator(color: Colors.white,),
                          )
                          : Button(
                            text: "REGISTRAR",
                            color: secondaryColor,
                            press: (){
                              final isValid = _formKey.currentState!.validate();
                              if (isValid) {
                                _formKey.currentState!.save();
                                Provider.of<ChildRegisterPresenter>(context, listen: false).setLoader(true);
                                Provider.of<ChildRegisterPresenter>(context, listen: false).registerChild().then((value){
                                  if(value){
                                    Provider.of<ChildRegisterPresenter>(context, listen: false).setLoader(false);
                                    Navigator.pop(context);
                                  }
                                  else{
                                    Provider.of<ChildRegisterPresenter>(context, listen: false).setLoader(false);
                                  }
                                });
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
          ),
        )
    );
  }
}