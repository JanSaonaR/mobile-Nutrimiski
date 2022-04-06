import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:mobile_nutrimiski/view/pages/main/app_page.dart';
import 'package:mobile_nutrimiski/view/widgets/child/child_preferences_items.dart';
import 'package:provider/provider.dart';
import '../../../presenter/child_register_presenter.dart';
import '../../widgets/common/button.dart';

class RegisterChildPreferencesPage extends StatelessWidget {
  const RegisterChildPreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //final registeredChild = Provider.of<ChildRegisterPresenter>(context, listen: false).getRegisteredChildId();

    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          margin: const EdgeInsets.only(right: 10.0, left: 20.0),
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TITLE
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: ()=> Navigator.pop(context),
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: primaryColor,
                        child: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                      ),
                    ),
                    const Expanded(
                        child: Center(
                          child: Text('LOGO', style: TextStyle(color: secondaryColor,
                              fontSize: 30, fontWeight: FontWeight.bold)),
                        )
                    ),
                    const SizedBox(width: 30)
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              const Text(
                'Preferencias',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: primaryColor
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Scrollbar(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ListView(
                      children: [
                        const Text(
                          'Proteínas',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: primaryColor
                          ),
                        ),
                        Container(
                          height: screenSize.height * 0.275,
                          width: screenSize.width,
                          margin: const EdgeInsets.symmetric(vertical: 17.5),
                          padding: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 4),
                                )
                              ]
                          ),
                          child: const ProteinPreferences(),
                        ),
                        const Text(
                          'Carbohidratos',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: primaryColor
                          ),
                        ),
                        Container(
                          height: screenSize.height * 0.275,
                          width: screenSize.width,
                          margin: const EdgeInsets.symmetric(vertical: 17.5),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 4),
                                )
                              ]
                          ),
                          child: const CarbohydratesPreferences(),
                        ),
                        const Text(
                          'Frutas',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: primaryColor
                          ),
                        ),
                        Container(
                          height: screenSize.height * 0.275,
                          width: screenSize.width,
                          margin: const EdgeInsets.symmetric(vertical: 17.5),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 4),
                                )
                              ]
                          ),
                          child: const FruitPreferences(),
                        ),
                        const Text(
                          'Grasas',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: primaryColor
                          ),
                        ),
                        Container(
                          height: screenSize.height * 0.275,
                          width: screenSize.width,
                          margin: const EdgeInsets.symmetric(vertical: 17.5),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 4),
                                )
                              ]
                          ),
                          child: const FatPreferences(),
                        ),
                        Center(
                          child: Button(
                            press: () {
                              //TODO: MANDAR LOS INGREDIENTES PREFERIDOS, YA SE TIENE ID DEL NIÑO REGISTRADO
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (BuildContext context) => const AppPage(),
                              ));
                            },
                            color: secondaryColor,
                            text: 'CONTINUAR',
                          ),
                        ),
                        const SizedBox(height: 17.5)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 17.5)
            ],
          ),
        ),
      ),
    );
  }
}
