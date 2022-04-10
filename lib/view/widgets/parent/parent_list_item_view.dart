import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_nutrimiski/model/entitie/parent.dart';
import 'package:mobile_nutrimiski/presenter/parent_presenter.dart';
import 'package:mobile_nutrimiski/view/pages/child/child_detail_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../presenter/child_presenter.dart';
import '../../../util/colors.dart';

class ParentListItemView extends StatefulWidget {

  final Parent parent;
  const ParentListItemView({Key? key, required this.parent}) : super(key: key);

  @override
  _ParentListItemViewState createState() => _ParentListItemViewState();
}

class _ParentListItemViewState extends State<ParentListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //dejo un niño seleccionado para evitar pasar el mismo child como parámetro
        Provider.of<ParentPresenter>(context, listen: false).selectedParent = widget.parent;
        Navigator.push(
            context,
            PageTransition(
                duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 200),
                type: PageTransitionType.rightToLeft,
                child: const ChildDetailsPage()
            )
        );
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
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                widget.parent.user!.picture != null ?
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.parent.user!.picture!.url!),
                  radius: 60,
                ) : const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/dad.png"),
                  radius: 60,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.parent.user!.firstName!, style: const TextStyle(fontWeight: FontWeight.bold),),
                    Text(widget.parent.user!.lastName!, style: const TextStyle(color: alternativeTextColor, fontSize: 12)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}