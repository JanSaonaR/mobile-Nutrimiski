import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_nutrimiski/view/pages/nutritional_plan/child_nutritional_plan.dart';
import 'package:mobile_nutrimiski/view/widgets/common/chart.dart';
import 'package:mobile_nutrimiski/view/widgets/common/child_information_chip.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../presenter/child_presenter.dart';
import '../../../util/colors.dart';
import '../../../util/util.dart';

class ChildDetailsPage extends StatefulWidget {
  const ChildDetailsPage({Key? key}) : super(key: key);

  @override
  State<ChildDetailsPage> createState() => _ChildDetailsPageState();
}

class _ChildDetailsPageState extends State<ChildDetailsPage> {

  final _formKey = GlobalKey<FormState>();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          title: const Text('Actualización de datos', style: TextStyle(color: primaryColor, fontSize: 15, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
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
                              hintText: 'Nueva Altura cm',
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
                                return "Ingrese la altura del niñ@";
                              }
                              // if (!value.contains("@")) {
                              //   return "Ingrese un correo valido";
                              // }
                            },
                            onSaved: (value) {
                              Provider.of<ChildPresenter>(context, listen: false).newHeight = double.parse(value!);
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
                              hintText: 'Nuevo Peso kg',
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
                                return "Ingrese el peso del niñ@";
                              }
                              // if (!value.contains("@")) {
                              //   return "Ingrese un correo valido";
                              // }
                            },
                            onSaved: (value) {
                              Provider.of<ChildPresenter>(context, listen: false).newWeight = double.parse(value!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar', style: TextStyle(color: primaryColor),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Actualizar', style: TextStyle(color: secondaryColor),),
              onPressed: () {
                final isValid = _formKey.currentState!.validate();
                if (isValid) {
                  _formKey.currentState!.save();
                  Provider.of<ChildPresenter>(context, listen: false).updateChild().then((value){
                    if(value){
                      Provider.of<ChildPresenter>(context, listen: false).setHistoryReady(0);
                      Provider.of<ChildPresenter>(context, listen: false).localChildUpdate();
                      Provider.of<ChildPresenter>(context, listen: false).getChildHistory().whenComplete((){
                        Navigator.of(context).pop();
                      });
                    }
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }


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
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: GestureDetector(
                        onTap: (){
                          Provider.of<ChildPresenter>(context, listen: false).setHistoryReady(0);
                          Navigator.pop(context);
                        },
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: primaryColor,
                          child: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Center(
                          child: Image.asset('assets/images/logo.png', scale: 5,),
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
                            child.sex == "M"
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(child.firstName!, style: const TextStyle(color: Colors.black, fontSize: 20.0)),
                                          Text(child.lastName!, style: const TextStyle(color: alternativeTextColor, fontSize: 13.0)),
                                        ],
                                      ),
                                      CircleAvatar(
                                        backgroundColor: primaryColor,
                                        radius: 20,
                                        child: InkWell(
                                          onTap: (){
                                            _showMyDialog().whenComplete((){
                                              setState(() {});
                                            });
                                          },
                                          child: Icon(Icons.edit, color: Colors.white,),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          const FaIcon(FontAwesomeIcons.weight, size: 15.0, color: alternativeTextColor),
                                          const SizedBox(width: 10.0),
                                          Container(
                                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                color: setPatientStateColor(child.imc!)),
                                              child: Text(setPatientStateName(child.imc!), style: const TextStyle(color: Colors.white, fontSize: 13.0)))
                                        ],
                                      ),

                                      ChildInformationChip(
                                        text: '${child.age} años',
                                        icon: FontAwesomeIcons.hourglass
                                      ),
                                      ChildInformationChip(
                                        text: child.sex == "M"
                                        ? "Hombre" : "Mujer",
                                        icon: FontAwesomeIcons.child
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("IMC", style: TextStyle(fontSize: 16.0)),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      children: [
                                        const Text('Prom.   '),
                                        Text(Provider.of<ChildPresenter>(context).selectedChild.imc!.toStringAsFixed(2), style: const TextStyle(fontSize: 20.0))
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          primary: Provider.of<ChildPresenter>(context).getSelectedChart() == 1 ? primaryColor : Colors.white,
                                        ),
                                        onPressed: (){
                                      Provider.of<ChildPresenter>(context, listen: false).setSelectedChart(1);
                                    }, child: Text('Semana', style: TextStyle(color: Provider.of<ChildPresenter>(context).getSelectedChart() == 1 ? Colors.white : primaryColor,),)),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          primary: Provider.of<ChildPresenter>(context).getSelectedChart() == 2 ? primaryColor : Colors.white,
                                        ),
                                        onPressed: (){
                                      Provider.of<ChildPresenter>(context, listen: false).setSelectedChart(2);
                                    }, child: Text('Mes', style: TextStyle(color: Provider.of<ChildPresenter>(context).getSelectedChart() == 2 ? Colors.white : primaryColor,),)),
                                  ],
                                )
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
