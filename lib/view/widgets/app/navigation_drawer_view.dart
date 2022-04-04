import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:mobile_nutrimiski/view/pages/authentication/authentication_page.dart';
import 'package:mobile_nutrimiski/view/pages/authentication/login_page.dart';
import 'package:page_transition/page_transition.dart';

import '../../../model/entitie/user_session.dart';
import '../../../util/util.dart';

class NavigationDrawer extends StatefulWidget {

  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      child: Container(
        padding: const EdgeInsets.only(top: 100, left: 30, right: 30, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(15.0)),
                    image: UserSession().getImage() != null ?
                    DecorationImage(
                      image:  NetworkImage(UserSession().getImage()!),
                      fit: BoxFit.cover,
                    ) :
                    const DecorationImage(
                      image: AssetImage("assets/images/dad.png"),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  getUserName(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                const SizedBox(
                  height: 5,
                ),
                Text(UserSession().getEmail(), style: const TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 0,
                  primary: primaryColor,
                  onPrimary: textFieldColor
                ),
                onPressed: (){
                  UserSession().logOut();
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 200),
                          reverseDuration: const Duration(milliseconds: 200),
                          type: PageTransitionType.rightToLeft,
                          child: const AuthenticationPage()
                      )
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    FaIcon(FontAwesomeIcons.signOutAlt, color: specialTextColor),
                    Text('Cerrar Sesión', style: TextStyle(color: specialTextColor),)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}