import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/presenter/child_presenter.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:mobile_nutrimiski/view/pages/child/register_child_page.dart';
import 'package:mobile_nutrimiski/view/pages/child/register_child_preferences_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../model/entitie/child.dart';
import '../../widgets/child/child_list_item_view.dart';

class ChildListPage extends StatefulWidget {
    const ChildListPage({Key? key}) : super(key: key);

  @override
  _ChildListPageState createState() => _ChildListPageState();
}

class _ChildListPageState extends State<ChildListPage> {

  @override
  Widget build(BuildContext context) {

    final children = Provider.of<ChildPresenter>(context).children;

    final screenSize = MediaQuery.of(context).size;


    return SizedBox(
      height: screenSize.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Lista de Hijos', style: TextStyle(color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),),

          Expanded(
            child: Stack(
              children: [
                children.isNotEmpty ? Positioned.fill(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: children.length,
                    itemBuilder: (BuildContext context, int index) {

                      Child child = children[index];

                      return ChildListItemView(child: child, index: index);
                    },
                  ),
                ) : const Center(child: Text('Ups!, parece ser que no tienes hijos registrados', style: TextStyle(color: Colors.grey, fontSize: 12))),
                Positioned(
                  top: screenSize.height * 0.65,
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
                                //ABAJO ME DEJA IR DIRECTAMENTE A LA LISTA DE PREFERENCIAS SIN REGISTRO
                                //child: const RegisterChildPreferencesPage()
                            )
                        );
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}