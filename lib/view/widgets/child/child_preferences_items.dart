import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/view/widgets/common/grid_item.dart';

class ProteinPreferences extends StatefulWidget {
  const ProteinPreferences({Key? key}) : super(key: key);

  @override
  State<ProteinPreferences> createState() => _ProteinPreferencesState();
}

class _ProteinPreferencesState extends State<ProteinPreferences> {

  //CRUDO
  List<String> protein = ['Pollo', 'Carne', 'Huevo', 'Pescado', 'Atún', 'Pavita', 'Cerdo', 'Jamón', 'Leche', 'Yogurt'];

  //LISTA PARA PROVIDERS
  List<String> selectedProtein = [];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
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
      ),
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

  List<String> carbohydrates = ['Papa', 'Arroz', 'Fideo', 'Pan', 'Choclo', 'Lenteja', 'Frijol', 'Camote', 'Yuca', 'Avena', 'Quinoa'];

  List<String> selectedCarbohydrates = [];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
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
      ),
    );
  }
}

class FatPreferences extends StatefulWidget {
  const FatPreferences({Key? key}) : super(key: key);

  @override
  State<FatPreferences> createState() => _FatPreferencesState();
}

class _FatPreferencesState extends State<FatPreferences> {
  //CRUDO
  List<String> fat = ['Palta', 'Aceite', 'Leche', 'Mantequilla', 'Queso', 'Coco'];

  //LISTA PARA PROVIDERS
  List<String> selectedFat = [];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 90,
          mainAxisExtent: 50,
          crossAxisSpacing: 65.0,
          mainAxisSpacing: 30.0,
        ),
        itemCount: fat.length,
        itemBuilder: (context, index) {
          return GridItem(
              value: fat[index],
              isSelected: (bool value) {
                setState(() {
                  if(value) {
                    selectedFat.add(fat[index]);
                  } else {
                    selectedFat.remove(fat[index]);
                  }
                });
              }
          );
        },
      ),
    );
  }
}

class FruitPreferences extends StatefulWidget {
  const FruitPreferences({Key? key}) : super(key: key);

  @override
  State<FruitPreferences> createState() => _FruitPreferencesState();
}

class _FruitPreferencesState extends State<FruitPreferences> {
  //CRUDO
  List<String> fruit = ['Naranja', 'Mandarina', 'Maracuyá', 'Manzana',
    'Plátano', 'Uva', 'Cocona', 'Mango', 'Papaya', 'Granadilla', 'Piña'];

  //LISTA PARA PROVIDERS
  List<String> selectedFruit = [];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 90,
          mainAxisExtent: 50,
          crossAxisSpacing: 65.0,
          mainAxisSpacing: 30.0,
        ),
        itemCount: fruit.length,
        itemBuilder: (context, index) {
          return GridItem(
              value: fruit[index],
              isSelected: (bool value) {
                setState(() {
                  if(value) {
                    selectedFruit.add(fruit[index]);
                  } else {
                    selectedFruit.remove(fruit[index]);
                  }
                });
              }
          );
        },
      ),
    );
  }
}
