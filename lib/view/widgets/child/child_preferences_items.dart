import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/view/widgets/common/grid_item.dart';

class ProteinPreferences extends StatefulWidget {
  const ProteinPreferences({Key? key}) : super(key: key);

  @override
  State<ProteinPreferences> createState() => _ProteinPreferencesState();
}

class _ProteinPreferencesState extends State<ProteinPreferences> {

  //CRUDO
  List<String> protein = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

  //LISTA PARA PROVIDERS
  List<String> selectedProtein = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 90,
        mainAxisExtent: 50,
        crossAxisSpacing: 65.0,
        mainAxisSpacing: 30.0,
      ),
      itemCount: protein.length,
      itemBuilder: (context, index) {
        return GridItem(
          value: protein[index],
          isSelected: (bool value) {
            setState(() {
              if(value) {
                selectedProtein.add(protein[index]);
              } else {
                selectedProtein.remove(protein[index]);
              }
            });
          }
        );
      },
    );
  }
}

class CarbohydratesPreferences extends StatefulWidget {
  const CarbohydratesPreferences({Key? key}) : super(key: key);

  @override
  State<CarbohydratesPreferences> createState() => _CarbohydratesPreferencesState();
}

class _CarbohydratesPreferencesState extends State<CarbohydratesPreferences> {

  //CRUDO

  List<String> carbohydrates = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

  List<String> selectedCarbohydrates = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 90,
        mainAxisExtent: 50,
        crossAxisSpacing: 65.0,
        mainAxisSpacing: 30.0,
      ),
      itemCount: carbohydrates.length,
      itemBuilder: (context, index) {
        return GridItem(
            value: carbohydrates[index],
            isSelected: (bool value) {
              setState(() {
                if(value) {
                  selectedCarbohydrates.add(carbohydrates[index]);
                } else {
                  selectedCarbohydrates.remove(carbohydrates[index]);
                }
              });
            }
        );
      },
    );
  }
}

