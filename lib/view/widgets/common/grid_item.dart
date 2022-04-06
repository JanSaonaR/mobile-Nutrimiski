import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/util/colors.dart';

class GridItem extends StatefulWidget {
  final String value;
  final ValueChanged<bool> isSelected;

  const GridItem({required this.value,
    required this.isSelected, Key? key}) : super(key: key);

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
          widget.isSelected(isSelected);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Center(
          child: Text(widget.value, style: const TextStyle(fontSize: 11.5)),
        ),
      )
    );
  }
}
