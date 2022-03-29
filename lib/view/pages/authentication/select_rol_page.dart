import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/util/colors.dart';

import '../../widgets/common/button.dart';

class SelectRolPage extends StatefulWidget {
  final VoidCallback goToRegisterForm;
  const SelectRolPage({Key? key, required this.goToRegisterForm}) : super(key: key);

  @override
  _SelectRolPageState createState() => _SelectRolPageState();
}

class _SelectRolPageState extends State<SelectRolPage> {

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
            const Positioned(
              top: 20, left: 50,
              child: Text('LOGO', style: TextStyle(color: secondaryColor, fontSize: 40, fontWeight: FontWeight.bold),),
            ),
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background_image.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 15.0),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(44, 53, 73, 0.95),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/images/background_image.jpg'),
                    ),
                    const SizedBox(height: 20.0),
                    const SizedBox(
                      width: 200,
                      child: Text('Lleva el control de la alimentacion  de tus hijos y contacta con expertos para complementar sus dietas.', textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.normal),),
                    ),
                    SizedBox(height: screenSize.height/50),
                    Button(
                      text: "PADRE",
                      color: secondaryColor,
                      press: widget.goToRegisterForm,
                    ),
                    SizedBox(height: 10),
                    Button(
                      text: "NUTRICIONISTA",
                      color: secondaryColor,
                      press: widget.goToRegisterForm,
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