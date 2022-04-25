import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/util/colors.dart';

import '../../widgets/common/button.dart';

class RegisterSuccessPage extends StatefulWidget {
  final VoidCallback goBack;
  const RegisterSuccessPage({Key? key, required this.goBack}) : super(key: key);

  @override
  _RegisterSuccessPageState createState() => _RegisterSuccessPageState();
}

class _RegisterSuccessPageState extends State<RegisterSuccessPage> {

  late bool loader;

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Material(
        color: backgroundColor,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 120, bottom: 50, left: 30, right: 30),
              height: MediaQuery.of(context).size.height/1.5,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: screenSize.height/80),
                  const Text('LISTO!', style: TextStyle(color: primaryColor, fontSize: 30, fontWeight: FontWeight.bold),),
                  const Text('Su cuenta ha sido creada', style: TextStyle(color: primaryColor, fontSize: 15, fontWeight: FontWeight.bold),),
                  const Icon(Icons.check_circle_outline_rounded, color: primaryColor, size: 200,),
                  Button(
                    text: "CONTINUAR",
                    color: secondaryColor,
                    press: widget.goBack,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
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
          ],
        )
    );
  }
}