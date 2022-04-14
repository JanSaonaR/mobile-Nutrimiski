import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_nutrimiski/view/pages/nutritional_plan/child_nutritional_plan.dart';
import 'package:mobile_nutrimiski/view/widgets/common/chart.dart';
import 'package:mobile_nutrimiski/view/widgets/common/child_information_chip.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../presenter/child_presenter.dart';
import '../../../util/colors.dart';

class ChildDetailsPage extends StatefulWidget {
  const ChildDetailsPage({Key? key}) : super(key: key);

  @override
  State<ChildDetailsPage> createState() => _ChildDetailsPageState();
}

class _ChildDetailsPageState extends State<ChildDetailsPage> {
  @override
  Widget build(BuildContext context) {

    final child = Provider.of<ChildPresenter>(context, listen: false).selectedChild;

    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        extendBody: true,
        body: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            children: [
              //TITLE
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
              //CHILD IMAGE AND INFORMATION
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: screenSize.height * 0.30,
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            child.sex == "H"
                            ? 'assets/images/boy.png'
                            : 'assets/images/girl.png'
                          ),
                          fit: BoxFit.cover
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20.0,
                      child: Container(
                        height: screenSize.height * 0.58,
                        width: screenSize.width * 0.90,
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 15.0
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 100.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(child.firstName!, style: const TextStyle(color: Colors.black, fontSize: 20.0)),
                                  Text(child.lastName!, style: const TextStyle(color: alternativeTextColor, fontSize: 13.0)),
                                  Row(
                                    children: [
                                      ChildInformationChip(
                                        text: '${child.age} años',
                                        icon: FontAwesomeIcons.hourglass
                                      ),
                                      const SizedBox(width: 60),
                                      ChildInformationChip(
                                        text: child.sex == "H"
                                        ? "Hombre" : "Mujer",
                                        icon: FontAwesomeIcons.child
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("IMC", style: TextStyle(fontSize: 16.0)),
                                const SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    const Text('Prom.   '),
                                    Text(child.imc!.toStringAsFixed(2), style: const TextStyle(fontSize: 20.0))
                                  ],
                                ),
                              ],
                            ),
                            const ChildBMIChart(),
                            ElevatedButton(
                              onPressed: (){
                                //TODO: PLAN NUTRICIONAL SEMANAL
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        duration: const Duration(milliseconds: 200),
                                        reverseDuration: const Duration(milliseconds: 200),
                                        type: PageTransitionType.rightToLeft,
                                        child: const ChildNutritionalPlanPage()
                                    )
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                primary: secondaryColor,
                                fixedSize: Size(screenSize.width * 0.65, 60),
                                elevation: 0
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 55),
                                  const Expanded(
                                    child: Center(
                                      child: Text(
                                        'PLAN NUTRICIONAL',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  Image.asset('assets/images/Vector.png', height: 55, width: 55, fit: BoxFit.cover,)
                                ],
                              )
                            )
                          ]
                        ),
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
  }
}
