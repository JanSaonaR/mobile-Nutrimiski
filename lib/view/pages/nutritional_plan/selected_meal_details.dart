import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/model/entitie/calories_detail.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/entitie/meal.dart';
import '../../../presenter/meal_presenter.dart';
import '../../../util/colors.dart';
import '../../../util/util.dart';

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class MealDetailsPage extends StatefulWidget {
  const MealDetailsPage({Key? key}) : super(key: key);

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {

  bool changed = false;

  @override
  Widget build(BuildContext context) {

    final meal = Provider.of<MealPresenter>(context, listen: false).selectedMeal;

    final List<CalorieDetail> caloriesData = [
      CalorieDetail('Grasas', double.parse(meal.fat.toString())),
      CalorieDetail('Proteinas', double.parse(meal.protein.toString())),
      CalorieDetail('Carbohidratos', double.parse(meal.carbohydrates.toString())),
    ];

    final screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if(changed == true) {
          Navigator.pop(context, true);
        } else {
          Navigator.pop(context, false);
        }
        return true;
      },
      child: SafeArea(
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
                        padding: const EdgeInsets.only(top: 10.0),
                        child: GestureDetector(
                          onTap: (){
                            if(changed == true) {
                              Navigator.pop(context, true);
                            } else {
                              Navigator.pop(context, false);
                            }
                          },
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: primaryColor,
                            child: Icon(Icons.arrow_back, color: Colors.white, size: 20,),
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
                //MEAL IMAGE AND INFO
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: screenSize.height * 0.30,
                        width: screenSize.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/ramen.jpg'),
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
                              horizontal: 30.0,
                              vertical: 30.0
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: screenSize.width * 0.45,
                                    child: Text(meal.name!, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Calorías', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          const Text('·', style: TextStyle(color: secondaryColor, fontSize: 40, fontWeight: FontWeight.bold),),
                                          Text('${meal.totalCalories}', style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                                          const Text(' kcal')
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 15.0),
                              const Text('Ingredientes: ', style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.grey)),
                              const SizedBox(height: 5.0),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: meal.ingredients!.split("-").map((e) => Text(
                                      '- ${e.toTitleCase()}'
                                      , style: TextStyle(color: Colors.grey),)).toList(),
                                  ),
                                  SizedBox(
                                    width: screenSize.width * 0.55,
                                    height: screenSize.width * 0.2,
                                    child: SfCartesianChart(
                                      plotAreaBorderWidth: 0,
                                      palette: const [
                                        secondaryColor,
                                        Color(0XFFFFEA29),
                                        Color(0XFFFF003E)
                                      ],
                                      series: <ChartSeries>[
                                        BarSeries<CalorieDetail, String>(
                                            dataSource: caloriesData,
                                            xValueMapper: (CalorieDetail cd, _) => cd.calorie,
                                            yValueMapper: (CalorieDetail cd, _) => cd.q,
                                            dataLabelSettings: const DataLabelSettings(
                                                alignment: ChartAlignment.center,
                                                labelAlignment: ChartDataLabelAlignment.outer,
                                                isVisible: true,
                                                textStyle: TextStyle(color: primaryColor)
                                            ))
                                      ],
                                      primaryXAxis: CategoryAxis(
                                        borderColor: Colors.white,
                                        borderWidth: 2,
                                        labelStyle: const TextStyle(color: primaryColor),
                                        majorGridLines: MajorGridLines(width: 0),
                                      ),
                                      primaryYAxis: NumericAxis(
                                          isVisible: false
                                      ),),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenSize.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.change_circle, size: 20),
                                  SizedBox(width: 5,),
                                  Text('Alternativas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                ],
                              ),
                              Container(
                                width: screenSize.width * 0.8,
                                margin: const EdgeInsets.symmetric(vertical: 10.0),
                                child: FutureBuilder(
                                  future: Provider.of<MealPresenter>(context, listen: false).getAlternativeMeals(context),
                                  builder: (context, snapshot) {
                                    if(snapshot.connectionState == ConnectionState.done) {

                                      List<Meal> meals = Provider.of<MealPresenter>(context, listen: false).getAlternativeMealsList();

                                      if(meals.isEmpty || meals == null) {
                                        return const Center(child: Text('No existen comidas alternativas para el día de hoy'));
                                      } else {
                                        return Column(
                                          children: meals.map((currentMeal) => GestureDetector(
                                            onTap: (){
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                                                    actionsAlignment: isParent() ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                                                    title: const Text('Cambiar alimento', style: TextStyle(color: primaryColor, fontSize: 15, fontWeight: FontWeight.bold)),
                                                    content: Text(isParent() ? 'Póngase en contacto con el nutricionista si desea cambiar este alimento.' : '¿Desea cambiar este alimento?', style: TextStyle(color: primaryColor, fontSize: 14),),
                                                    actions: [
                                                      Visibility(
                                                        visible: isParent(),
                                                        child: TextButton(
                                                          child: const Text('Ok', style: TextStyle(color: secondaryColor),),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: !isParent(),
                                                        child: TextButton(
                                                          child: const Text('No', style: TextStyle(color: primaryColor),),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: !isParent(),
                                                        child: TextButton(
                                                          child: const Text('Si', style: TextStyle(color: secondaryColor),),
                                                          onPressed: () {
                                                            changed = true;
                                                            Provider.of<MealPresenter>(context, listen: false).mealToReplace = currentMeal;
                                                            Provider.of<MealPresenter>(context, listen: false).replaceAlternativeMeal(context).then((value){
                                                              setState(() {
                                                                Provider.of<MealPresenter>(context, listen: false).selectedMeal = value;
                                                                currentMeal = value;
                                                              });
                                                            }).whenComplete(()=> Navigator.pop(context));
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                              );
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.05),
                                                      spreadRadius: 1,
                                                      blurRadius: 5,
                                                      offset: const Offset(0, 5),
                                                    )
                                                  ],
                                                  borderRadius: const BorderRadius.all(Radius.circular(25))
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 40,
                                                    backgroundImage: AssetImage('assets/images/ramen.jpg'),
                                                  ),
                                                  const SizedBox(width: 15.0),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(currentMeal.name!, overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: false, style: const TextStyle(color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.bold)),
                                                        Text('${currentMeal.totalCalories.toString()} kcal', style: const TextStyle(color: Colors.grey, fontSize: 12.0)),
                                                        SizedBox(
                                                          height: screenSize.height * 0.02,
                                                        ),
                                                        Align(alignment: Alignment.bottomRight, child: Text(currentMeal.schedule!, style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )).toList(),
                                        );
                                      }
                                    } else {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
