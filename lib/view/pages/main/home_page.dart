import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../model/entitie/meal.dart';
import '../../../presenter/child_presenter.dart';
import '../../../presenter/meal_presenter.dart';
import '../../../util/colors.dart';

dayOfWeek(String day) {
  switch (day) {
    case 'Monday': return 'Lunes';
    case 'Tuesday': return 'Martes';
    case 'Wednesday': return 'Miércoles';
    case 'Thursday': return 'Jueves';
    case 'Friday': return 'Viernes';
    case 'Saturday': return 'Sábado';
    case 'Sunday': return 'Domingo';
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {



    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //DIA DE LA SEMANA
          Text(dayOfWeek(DateFormat('EEEE').format(DateTime.now().add(const Duration(days: 5)))), style: const TextStyle(color: primaryColor,
              fontSize: 24.0, fontWeight: FontWeight.bold)),
          Text(DateFormat.yMMMd('es_ES').format(DateTime.now()).replaceAll(".", ","), style: const TextStyle(color: primaryColor,
              fontSize: 15.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15.0),
          FutureBuilder(
            future: Provider.of<ChildPresenter>(context, listen: false).getChildren(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                final children = Provider.of<ChildPresenter>(context, listen: false).children;

                return CarouselSlider.builder(
                    itemCount: children.length,
                    options: CarouselOptions(
                      height: screenSize.height * 0.7,
                      aspectRatio: 16/9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
                      return FutureBuilder(
                        future: Provider.of<MealPresenter>(context, listen: false).getMealsByDayByChild(context,
                            DateTime.now().toString().substring(0,10),
                            children[itemIndex].childId!),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.done) {

                            List<Meal> meals = Provider.of<MealPresenter>(context, listen: false).getMealsByDayByChildList();

                            //VALIDADOR SI EL NIÑO SE CREÓ EL DÍA ACTUAL

                            if(meals.isEmpty || meals == null) {
                              if(children[itemIndex].sex == 'M') {
                                return const Center(child: Text('Su hijo no cuenta con comidas para hoy'));
                              } else {
                                return const Center(child: Text('Su hija no cuenta con comidas para hoy'));
                              }
                            }
                            else {
                              return SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                                      child: Row(
                                        children: [
                                          const Text('Comidas de ', style: TextStyle(fontSize: 15.0, color: primaryColor)),
                                          Text('${children[itemIndex].firstName}', style: const TextStyle(fontSize: 18.0, color: secondaryColor, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: screenSize.height * 0.31,
                                        width: screenSize.width,
                                        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.5),
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.05),
                                                spreadRadius: 1,
                                                blurRadius: 8,
                                                offset: const Offset(2, 8),
                                              )
                                            ],
                                            borderRadius: const BorderRadius.all(Radius.circular(25))
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(meals[0].schedule!, style: const TextStyle(fontSize: 20.0, color: primaryColor)),
                                            const SizedBox(height: 8.0),
                                            SizedBox(
                                                width: screenSize.width * 0.5,
                                                child: Text(meals[0].name!, style: const TextStyle(fontSize: 14.0, color: primaryColor, fontWeight: FontWeight.bold))),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text('${meals[0].totalCalories} kcal', style: const TextStyle(fontSize: 20.0, color: primaryColor, fontWeight: FontWeight.bold)),
                                                  CircleAvatar(
                                                    radius: screenSize.height * 0.1,
                                                    backgroundImage: AssetImage('assets/images/ramen.jpg'),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10.0),
                                      child: Text('Próximas comidas', style: TextStyle(fontSize: 15.0, color: primaryColor, fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.05),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(2, 8),
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
                                                Text(meals[1].name!, overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: false, style: const TextStyle(color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.bold)),
                                                Text('${meals[1].totalCalories.toString()} kcal', style: const TextStyle(color: Colors.grey, fontSize: 12.0)),
                                                SizedBox(
                                                  height: screenSize.height * 0.009,
                                                ),
                                                Align(alignment: Alignment.bottomRight, child: Text(meals[1].schedule!, style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.05),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(2, 8),
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
                                                Text(meals[2].name!, overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: false, style: const TextStyle(color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.bold)),
                                                Text('${meals[2].totalCalories.toString()} kcal', style: const TextStyle(color: Colors.grey, fontSize: 12.0)),
                                                SizedBox(
                                                  height: screenSize.height * 0.009,
                                                ),
                                                Align(alignment: Alignment.bottomRight, child: Text(meals[2].schedule!, style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                          }
                          else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                      );

                    }
                );
              } else {
                return const Expanded(child: Center(child: Text('Cargando...')));
              }
            },
          ),
        ],
      ),
    );
  }
}
