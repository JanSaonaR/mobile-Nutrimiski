import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/model/entitie/category_ingredient.dart';
import 'package:mobile_nutrimiski/presenter/child_presenter.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:provider/provider.dart';

class GridItem extends StatefulWidget {
  final CategoryIngredient ingredient;

  const GridItem({required this.ingredient, Key? key}) : super(key: key);

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        if(isSelected == true) {
          Provider.of<ChildPresenter>(context, listen: false).addPreferenceToList(widget.ingredient);
        }
        else {
          Provider.of<ChildPresenter>(context, listen: false).removePreferenceFromList(widget.ingredient);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Center(
          child: Text(widget.ingredient.name!, style: const TextStyle(fontSize: 11.5)),
        ),
      )
    );
  }
}
