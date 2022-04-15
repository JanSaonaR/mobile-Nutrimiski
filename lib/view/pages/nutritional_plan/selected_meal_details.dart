import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/entitie/meal.dart';
import '../../../presenter/meal_presenter.dart';
import '../../../util/colors.dart';

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
  @override
  Widget build(BuildContext context) {

    final meal = Provider.of<MealPresenter>(context, listen: false).selectedMeal;

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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: screenSize.width * 0.45,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(meal.name!, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 15.0),
                                      const Text('Ingredientes: '),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: meal.ingredients!.split("-").map((e) => Text(
                                            '- ${e.toTitleCase()}'
                                        )).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Text('Calorías', style: TextStyle(fontSize: 20.0)),
                                    Row(
                                      children: [
                                        const Text('·', style: TextStyle(color: secondaryColor, fontSize: 20.0)),
                                        Text('${meal.totalCalories}', style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                        const Text(' kcal')
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: screenSize.width * 0.75,
                              height: screenSize.height * 0.45,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
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
                                            // Provider.of<MealPresenter>(context, listen: false).selectedMeal = currentMeal;
                                            // Navigator.push(
                                            //     context,
                                            //     PageTransition(
                                            //         duration: const Duration(milliseconds: 200),
                                            //         reverseDuration: const Duration(milliseconds: 200),
                                            //         type: PageTransitionType.rightToLeft,
                                            //         child: const MealDetailsPage()
                                            //     )
                                            // );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                                                  radius: 40,
                                                  backgroundImage: AssetImage('assets/images/ramen.jpg'),
                                                ),
                                                const SizedBox(width: 15.0),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(currentMeal.name!, overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: false, style: const TextStyle(color: Colors.grey, fontSize: 12.0)),
                                                      Text('${currentMeal.totalCalories.toString()} kcal', style: const TextStyle(color: Colors.grey, fontSize: 12.0)),
                                                      Align(alignment: Alignment.bottomRight, child: Text(currentMeal.schedule!, style: const TextStyle(fontSize: 14.0)))
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
    );
  }
}
