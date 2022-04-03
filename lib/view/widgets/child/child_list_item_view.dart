import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/model/entitie/child.dart';

import '../../../util/colors.dart';

class ChildListItemView extends StatefulWidget {

  final Child child;
  const ChildListItemView({Key? key, required this.child}) : super(key: key);

  @override
  _ChildListItemViewState createState() => _ChildListItemViewState();
}

class _ChildListItemViewState extends State<ChildListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
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
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/parent.jpg"),
              radius: 60,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.child.firstName!, style: const TextStyle(fontWeight: FontWeight.bold),),
                Text(widget.child.lastName!, style: const TextStyle(color: alternativeTextColor, fontSize: 12)),
                Text(widget.child.age.toString() + " años", style: const TextStyle(color: alternativeTextColor, fontSize: 12)),
              ],
            )
          ],
        ),
      ),
    );
  }
}