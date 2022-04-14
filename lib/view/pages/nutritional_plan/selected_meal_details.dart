import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../presenter/meal_presenter.dart';
import '../../../util/colors.dart';

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
                      decoration: BoxDecoration(
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
                                  height: 100.0,
                                  width: screenSize.width * 0.45,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(meal.name!, overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: false),
                                      Text(meal.ingredients!, overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: false),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text('Calorías'),
                                    Row(
                                      children: [
                                        Text('·', style: TextStyle(color: secondaryColor, fontSize: 20.0)),
                                        Text('${meal.totalCalories}', style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(' kcal')
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
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
