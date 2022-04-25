import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/util/colors.dart';

class ChildDailyNutritionalPlanPage extends StatefulWidget {
  const ChildDailyNutritionalPlanPage({Key? key}) : super(key: key);

  @override
  State<ChildDailyNutritionalPlanPage> createState() => _ChildDailyNutritionalPlanPageState();
}

class _ChildDailyNutritionalPlanPageState extends State<ChildDailyNutritionalPlanPage> {
  @override
  Widget build(BuildContext context) {

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
              const Expanded(
                  child: Center(
                    child: Text('LOGO', style: TextStyle(color: secondaryColor,
                        fontSize: 30, fontWeight: FontWeight.bold)),
                  )
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: ()=> Navigator.pop(context),
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: primaryColor,
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                    ),
                  ),
                  const Spacer(),
                  const Text('Plan nutricional', style: TextStyle(color: primaryColor,
                      fontSize: 20, fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
