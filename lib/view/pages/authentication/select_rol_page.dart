import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:provider/provider.dart';

import '../../../presenter/register_presenter.dart';
import '../../widgets/common/button.dart';

class SelectRolPage extends StatefulWidget {
  final VoidCallback goToUserRegisterForm;
  const SelectRolPage({Key? key, required this.goToUserRegisterForm}) : super(key: key);

  @override
  _SelectRolPageState createState() => _SelectRolPageState();
}

class _SelectRolPageState extends State<SelectRolPage> {

  late bool loader;
  bool isHiddenPassword = false;


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
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Provider.of<RegisterPresenter>(context).getImage(),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 100.0, bottom: 50.0, left: 15.0, right: 15.0),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(44, 53, 73, 0.95),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: Provider.of<RegisterPresenter>(context).getImage(),
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
                      color: Provider.of<RegisterPresenter>(context).getRol() == 0 ? secondaryColor : unSelectedRol,
                      press: (){
                        Provider.of<RegisterPresenter>(context, listen: false).setDesireRol(0);
                      },
                    ),
                    const SizedBox(height: 20),
                    Button(
                      text: "NUTRICIONISTA",
                      color: Provider.of<RegisterPresenter>(context).getRol() == 1 ? secondaryColor : unSelectedRol,
                      press: (){
                        Provider.of<RegisterPresenter>(context, listen: false).setDesireRol(1);
                      },
                    ),
                    const SizedBox(height: 50),
                    InkWell(
                      onTap: widget.goToUserRegisterForm,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Continuar', style: TextStyle(color: Colors.white),),
                          SizedBox(width: 5,),
                          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12,)
                        ],
                      ),
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