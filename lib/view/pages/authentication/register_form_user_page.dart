import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
  File? image;

  String gender = "Masculino";

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

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final _temp = File(image.path);
    Provider.of<RegisterPresenter>(context, listen: false).setFile(_temp);
    setState(() => this.image = _temp);

    //Provider.of<RegisterPresenter>(context, listen: false).validateImage(true);
  }

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
        Provider.of<RegisterPresenter>(context, listen: false).parentRegisterDto.birthDate = DateFormat("yyyy-MM-dd").format(picked);
        Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('birthDate', DateFormat("yyyy-MM-dd").format(picked));
        _birthDayController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
      _formKey.currentState!.validate();
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              ElevatedButton(
                                                  style: style,
                                                  onPressed: () async{
                                                    await pickImage(ImageSource.gallery);
                                                  },
                                                  child: const Text(
                                                    'Seleccionar Foto',
                                                    style: TextStyle(color: Colors.white),
                                                  )
                                              ),
                                              // Visibility(
                                              //     visible: Provider.of<RegisterPresenter>(context).getValidateImage() == false,
                                              //     child: Text('Seleccione una imagen', style: TextStyle(color: Colors.red, fontSize: 12),))
                                            ],
                                          ),
                                          CircleAvatar(
                                            backgroundImage: image == null ? Provider.of<RegisterPresenter>(context).getImage() : FileImage(image!),
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
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Ingrese un nombre";
                                            }
                                            if(!RegExp(r"^[a-zA-ZÀ-ÿ ´]+$").hasMatch(value)){
                                              return "Ingrese un nombre válido";
                                            }
                                          },
                                          onSaved: (value) {
                                            Provider.of<RegisterPresenter>(context, listen: false).parentRegisterDto.firstName = value!;
                                            Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('firstName', value);
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
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Ingrese un apellido";
                                            }
                                            if(!RegExp(r"^[a-zA-ZÀ-ÿ ´]+$").hasMatch(value)){
                                              return "Ingrese un apellido válido";
                                            }
                                          },
                                          onSaved: (value) {
                                            Provider.of<RegisterPresenter>(context, listen: false).parentRegisterDto.lastName = value!;
                                            Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('lastName', value);
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
                                            Provider.of<RegisterPresenter>(context, listen: false).parentRegisterDto.dni = value!;
                                            Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('dni', value);
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Container(
                                        width: 300,
                                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            dropdownColor: textFieldColor,
                                            value: gender,
                                            icon: const Icon(Icons.arrow_forward_ios, size: 14.0, color: Color.fromRGBO(255, 255, 255, 0.3)),
                                            style: GoogleFonts.inter(color: Colors.white),
                                            onChanged: (String? newValue){
                                              setState((){
                                                gender = newValue!;
                                                if (gender == 'Masculino') {
                                                  Provider.of<RegisterPresenter>(context, listen: false).parentRegisterDto.sex = "M";
                                                  Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('sex', "M");
                                                } else {
                                                  Provider.of<RegisterPresenter>(context, listen: false).parentRegisterDto.sex = "F";
                                                  Provider.of<RegisterPresenter>(context, listen: false).setUserRegisterDto('sex', "F");
                                                }
                                              });
                                            },
                                            items: <String>['Masculino', 'Femenino'].map<DropdownMenuItem<String>>((String value) {
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
                                        child: TextFormField(
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
                                          readOnly: true,
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            value = _birthDayController.value.text;
                                            if (value.isEmpty) {
                                              return "Ingrese fecha de nacimiento";
                                            }
                                            // if (!value.contains("@")) {
                                            //   return "Ingrese un correo valido";
                                            // }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
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
              ),
            ),
          ],
        )
    );
  }
}