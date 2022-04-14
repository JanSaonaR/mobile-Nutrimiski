import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/entitie/meal.dart';
import '../../../presenter/child_presenter.dart';
import '../../../presenter/meal_presenter.dart';
import '../../../util/colors.dart';

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
                    Center(
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
                        Text('Plan nutricional', style: TextStyle(color: primaryColor,
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
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selected = int.parse(DateTime.now().toString().substring(8,10));
                        selectedDate = DateTime.now().toString().substring(0,10);
                      });
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: selected == int.parse( DateTime.now().toString().substring(8,10)) ? primaryColor : Colors.white,
                      child: Text(DateTime.now().toString().substring(8,10),
                        style: TextStyle(color:
                          selected == int.parse(DateTime.now().toString().substring(8,10)) ? Colors.white : primaryColor,
                        )
                      ),
                    ),
                  ),
                  //+1
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selected = int.parse(DateTime.now().add(Duration(days: 1)).toString().substring(8,10));
                        selectedDate = DateTime.now().add(Duration(days: 1)).toString().substring(0,10);
                      });
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: selected == int.parse( DateTime.now().add(Duration(days: 1)).toString().substring(8,10)) ? primaryColor : Colors.white,
                      child: Text(DateTime.now().add(Duration(days: 1)).toString().substring(8,10),
                          style: TextStyle(color:
                          selected == int.parse(DateTime.now().add(Duration(days: 1)).toString().substring(8,10)) ? Colors.white : primaryColor,
                        )
                      ),
                    ),
                  ),
                  //+2
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selected = int.parse(DateTime.now().add(Duration(days: 2)).toString().substring(8,10));
                        selectedDate = DateTime.now().add(Duration(days: 2)).toString().substring(0,10);
                      });
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: selected == int.parse( DateTime.now().add(Duration(days: 2)).toString().substring(8,10)) ? primaryColor : Colors.white,
                      child: Text(DateTime.now().add(Duration(days: 2)).toString().substring(8,10),
                          style: TextStyle(color:
                          selected == int.parse(DateTime.now().add(Duration(days: 2)).toString().substring(8,10)) ? Colors.white : primaryColor,
                        )
                      ),
                    ),
                  ),
                  //+3
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selected = int.parse(DateTime.now().add(Duration(days: 3)).toString().substring(8,10));
                        selectedDate = DateTime.now().add(Duration(days: 3)).toString().substring(0,10);
                      });
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: selected == int.parse( DateTime.now().add(Duration(days: 3)).toString().substring(8,10)) ? primaryColor : Colors.white,
                      child: Text(DateTime.now().add(Duration(days: 3)).toString().substring(8,10),
                          style: TextStyle(color:
                          selected == int.parse(DateTime.now().add(Duration(days: 3)).toString().substring(8,10)) ? Colors.white : primaryColor,
                          )
                      ),
                    ),
                  ),
                  //+4
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selected = int.parse(DateTime.now().add(Duration(days: 4)).toString().substring(8,10));
                        selectedDate = DateTime.now().add(Duration(days: 4)).toString().substring(0,10);
                      });
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: selected == int.parse( DateTime.now().add(Duration(days: 4)).toString().substring(8,10)) ? primaryColor : Colors.white,
                      child: Text(DateTime.now().add(Duration(days: 4)).toString().substring(8,10),
                          style: TextStyle(color:
                          selected == int.parse(DateTime.now().add(Duration(days: 4)).toString().substring(8,10)) ? Colors.white : primaryColor,
                          )
                      ),
                    ),
                  ),
                  //+5
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        selected = int.parse(DateTime.now().add(Duration(days: 5)).toString().substring(8,10));
                        selectedDate = DateTime.now().add(Duration(days: 5)).toString().substring(0,10);
                      });
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: selected == int.parse( DateTime.now().add(Duration(days: 5)).toString().substring(8,10)) ? primaryColor : Colors.white,
                      child: Text(DateTime.now().add(Duration(days: 5)).toString().substring(8,10),
                          style: TextStyle(color:
                          selected == int.parse(DateTime.now().add(Duration(days: 5)).toString().substring(8,10)) ? Colors.white : primaryColor,
                          )
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<MealPresenter>(context, listen: false).getMealsByDay(context, selectedDate),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {

                      List<Meal> meals = Provider.of<MealPresenter>(context, listen: false).getMealsByDayList();

                      return ListView.builder(
                        itemCount: meals.length,
                        itemBuilder: (context, index) {

                          final currentMeal = meals[index];

                          return Container(
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
                                CircleAvatar(
                                  radius: 55,
                                  backgroundImage: AssetImage('assets/images/ramen.jpg'),
                                ),
                                Column(
                                  children: [
                                    Text(currentMeal.name!),
                                    Text(currentMeal.totalCalories.toString()),
                                    Text(currentMeal.schedule!)
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                    else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
