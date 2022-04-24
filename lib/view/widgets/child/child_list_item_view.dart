import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_nutrimiski/model/entitie/child.dart';
import 'package:mobile_nutrimiski/view/pages/child/child_detail_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../presenter/child_presenter.dart';
import '../../../util/colors.dart';

class ChildListItemView extends StatefulWidget {

  final Child child;
  final int index;
  const ChildListItemView({Key? key, required this.child, required this.index}) : super(key: key);

  @override
  _ChildListItemViewState createState() => _ChildListItemViewState();
}

class _ChildListItemViewState extends State<ChildListItemView> {

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          title: const Text('Eliminar', style: TextStyle(color: primaryColor, fontSize: 15, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('¿Seguro desea eliminar los datos de su hijo?', style: TextStyle(color: primaryColor, fontSize: 15)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No', style: TextStyle(color: primaryColor),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Si', style: TextStyle(color: secondaryColor),),
              onPressed: () {
                Provider.of<ChildPresenter>(context, listen: false).deleteChild(widget.index, widget.child.childId!).whenComplete((){
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //dejo un niño seleccionado para evitar pasar el mismo child como parámetro
        Provider.of<ChildPresenter>(context, listen: false).selectedChild = widget.child;
        Provider.of<ChildPresenter>(context, listen: false).selectedIndex = widget.index;
        Provider.of<ChildPresenter>(context, listen: false).getChildHistory();
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
          child: Slidable(
            actionPane: const SlidableDrawerActionPane(),
            actionExtentRatio: 0.30,
            secondaryActions: [
              IconSlideAction(
                onTap: () async {
                  _showMyDialog();
                },
                color: Colors.red,
                icon: Icons.delete,
                caption: 'Eliminar',
              )
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  widget.child.sex.toString() == "M" ?
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/boy.png"),
                    radius: 60,
                  ) : const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/girl.png"),
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
          ),
        ),
      ),
    );
  }
}