import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_nutrimiski/presenter/child_presenter.dart';
import 'package:mobile_nutrimiski/presenter/register_presenter.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:mobile_nutrimiski/view/pages/child/register_child_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../model/entitie/child.dart';
import '../../../util/styles.dart';
import '../../widgets/child/child_list_item_view.dart';
import '../../widgets/common/button.dart';

class ChildListPage extends StatefulWidget {
    const ChildListPage({Key? key}) : super(key: key);

  @override
  _ChildListPageState createState() => _ChildListPageState();
}

class _ChildListPageState extends State<ChildListPage> {

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height,
      child: Stack(
        children: [
          const Text('Lista de Hijos', style: TextStyle(color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),),
          ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: Provider.of<ChildPresenter>(context, listen: false).children.length,
            itemBuilder: (BuildContext context, int index) {

              Child child = Provider.of<ChildPresenter>(context, listen: false).children[index];

              return ChildListItemView(child: child,);
            },
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
                child: const Center(
                  child: Icon(
                      Icons.person_add
                  ),
                ),
                backgroundColor: primaryColor,
                elevation: 1,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 200),
                          reverseDuration: const Duration(milliseconds: 200),
                          type: PageTransitionType.rightToLeft,
                          child: const ChildRegisterFormPage()
                      )
                  );
                }),
          )
        ],
      ),
    );
  }
}