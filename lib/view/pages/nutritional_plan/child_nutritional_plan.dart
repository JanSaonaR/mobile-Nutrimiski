import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nutrimiski/view/pages/nutritional_plan/selected_meal_details.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../model/entitie/meal.dart';
import '../../../presenter/child_presenter.dart';
import '../../../presenter/meal_presenter.dart';
import '../../../util/colors.dart';

dayOfWeek(String day) {
  switch (day) {
    case 'Mon': return 'Lun';
    case 'Tue': return 'Mar';
    case 'Wed': return 'Mie';
    case 'Thu': return 'Jue';
    case 'Fri': return 'Vie';
    case 'Sat': return 'Sáb';
    case 'Sun': return 'Dom';
  }
}

class ChildNutritionalPlanPage extends StatefulWidget {
  const ChildNutritionalPlanPage({Key? key}) : super(key: key);

  @override
  State<ChildNutritionalPlanPage> createState() => _ChildNutritionalPlanPageState();
}

class _ChildNutritionalPlanPageState extends State<ChildNutritionalPlanPage> {

  //TODAY

  int selected = int.parse(DateTime.now().toString().substring(8,10));

  String selectedDate = DateTime.now().toString().substring(0,10);

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
                child: Column(
                  children: [
                    const Center(
                      child: Text('LOGO', style: TextStyle(color: secondaryColor,
                        fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: ()=> Navigator.pop(context),
                          child: const CircleAvatar(
                            radius: 25,
                            backgroundColor: primaryColor,
                            child: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                          ),
                        ),
                        const Text('Plan nutricional', style: TextStyle(color: primaryColor,
                          fontSize: 20.0)),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //TODAY
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            selected = int.parse(DateFormat('d').format(DateTime.now()));
                            selectedDate = DateTime.now().toString().substring(0,10);
                          });
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: selected == int.parse(DateFormat('d').format(DateTime.now())) ? primaryColor : Colors.white,
                          child: Text(DateFormat('d').format(DateTime.now()),
                            style: TextStyle(color:
                              selected == int.parse(DateFormat('d').format(DateTime.now())) ? Colors.white : primaryColor,
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Text(dayOfWeek(DateFormat('EEEE').format(DateTime.now()).substring(0,3)), style: const TextStyle(color: primaryColor,
                        fontSize: 13.0))
                    ],
                  ),
                  //+1
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            selected = int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 1))));
                            selectedDate = DateTime.now().add(const Duration(days: 1)).toString().substring(0,10);
                          });
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: selected == int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 1)))) ? primaryColor : Colors.white,
                          child: Text(DateFormat('d').format(DateTime.now().add(const Duration(days: 1))),
                              style: TextStyle(color:
                              selected == int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 1)))) ? Colors.white : primaryColor,
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Text(dayOfWeek(DateFormat('EEEE').format(DateTime.now().add(const Duration(days: 1))).substring(0,3)), style: const TextStyle(color: primaryColor,
                          fontSize: 13.0))
                    ],
                  ),
                  //+2
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            selected = int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 2))));
                            selectedDate = DateTime.now().add(const Duration(days: 2)).toString().substring(0,10);
                          });
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: selected == int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 2)))) ? primaryColor : Colors.white,
                          child: Text(DateFormat('d').format(DateTime.now().add(const Duration(days: 2))),
                              style: TextStyle(color:
                              selected == int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 2)))) ? Colors.white : primaryColor,
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Text(dayOfWeek(DateFormat('EEEE').format(DateTime.now().add(const Duration(days: 2))).substring(0,3)), style: const TextStyle(color: primaryColor,
                          fontSize: 13.0))
                    ],
                  ),
                  //+3
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            selected = int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 3))));
                            selectedDate = DateTime.now().add(const Duration(days: 3)).toString().substring(0,10);
                          });
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: selected == int.parse( DateTime.now().add(const Duration(days: 3)).toString().substring(8,10)) ? primaryColor : Colors.white,
                          child: Text(DateFormat('d').format(DateTime.now().add(const Duration(days: 3))),
                              style: TextStyle(color:
                              selected == int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 3)))) ? Colors.white : primaryColor,
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Text(dayOfWeek(DateFormat('EEEE').format(DateTime.now().add(const Duration(days: 3))).substring(0,3)), style: const TextStyle(color: primaryColor,
                          fontSize: 13.0))
                    ],
                  ),
                  //+4
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            selected = int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 4))));
                            selectedDate = DateTime.now().add(const Duration(days: 4)).toString().substring(0,10);
                          });
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: selected == int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 4)))) ? primaryColor : Colors.white,
                          child: Text(DateFormat('d').format(DateTime.now().add(const Duration(days: 4))),
                              style: TextStyle(color:
                              selected == int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 4)))) ? Colors.white : primaryColor,
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Text(dayOfWeek(DateFormat('EEEE').format(DateTime.now().add(const Duration(days: 4))).substring(0,3)), style: const TextStyle(color: primaryColor,
                          fontSize: 13.0))
                    ],
                  ),
                  //+5
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            selected = int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 5))));
                            selectedDate = DateTime.now().add(const Duration(days: 5)).toString().substring(0,10);
                          });
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: selected == int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 5)))) ? primaryColor : Colors.white,
                          child: Text(DateFormat('d').format(DateTime.now().add(const Duration(days: 5))),
                              style: TextStyle(color:
                              selected == int.parse(DateFormat('d').format(DateTime.now().add(const Duration(days: 5)))) ? Colors.white : primaryColor,
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Text(dayOfWeek(DateFormat('EEEE').format(DateTime.now().add(const Duration(days: 5))).substring(0,3)), style: const TextStyle(color: primaryColor,
                          fontSize: 13.0))
                    ],
                  )
                ],
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<MealPresenter>(context, listen: false).getMealsByDay(context, selectedDate),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {

                      List<Meal> meals = Provider.of<MealPresenter>(context, listen: false).getMealsByDayList();

                      if(meals.isEmpty || meals == null) {
                        return const Center(child: Text('No existen comidas agendadas para el día de hoy'));
                      } else {
                        return ListView.builder(
                          itemCount: meals.length,
                          itemBuilder: (context, index) {

                            final currentMeal = meals[index];

                            return GestureDetector(
                              onTap: () async {
                                Provider.of<MealPresenter>(context, listen: false).selectedMeal = currentMeal;
                                bool? value = await Navigator.push(
                                    context,
                                    MaterialPageRoute<bool>(
                                      builder: (context) {
                                        return const MealDetailsPage();
                                      }
                                    )
                                );
                                if(value == true) {
                                  setState(() {});
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                    borderRadius: const BorderRadius.all(Radius.circular(25))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const CircleAvatar(
                                      radius: 55,
                                      backgroundImage: AssetImage('assets/images/ramen.jpg'),
                                    ),
                                    const SizedBox(width: 15.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(currentMeal.name!, overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: false, style: const TextStyle(color: Colors.grey),),
                                          Text('${currentMeal.totalCalories.toString()} kcal', style: const TextStyle(color: Colors.grey),),
                                          Align(alignment: Alignment.bottomRight, child: Text(currentMeal.schedule!))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                    else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
                ),
              ),
              const SizedBox(height: 15.0)
            ],
          ),
        ),
      ),
    );
  }
}
