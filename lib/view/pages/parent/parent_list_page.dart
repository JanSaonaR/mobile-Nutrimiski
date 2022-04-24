import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/model/entitie/parent.dart';
import 'package:mobile_nutrimiski/presenter/child_presenter.dart';
import 'package:mobile_nutrimiski/presenter/parent_presenter.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:mobile_nutrimiski/view/pages/child/register_child_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../model/entitie/child.dart';
import '../../widgets/child/child_list_item_view.dart';
import '../../widgets/parent/parent_list_item_view.dart';

class ParentListPage extends StatefulWidget {
  const ParentListPage({Key? key}) : super(key: key);

  @override
  _ParentListPageState createState() => _ParentListPageState();
}

class _ParentListPageState extends State<ParentListPage> {

  @override
  Widget build(BuildContext context) {

    final parents = Provider.of<ParentPresenter>(context, listen: false).parents;

    final screenSize = MediaQuery.of(context).size;

    return Provider.of<ParentPresenter>(context).parentsReady ? SizedBox(
      height: screenSize.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Lista de padres', style: TextStyle(color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),),

          Expanded(
            child: Stack(
              children: [
                parents.isNotEmpty ? Positioned.fill(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: parents.length,
                    itemBuilder: (BuildContext context, int index) {

                      Parent parent = parents[index];

                      return ParentListItemView(parent: parent);
                    },
                  ),
                ) : const Center(child: Text('Ups!, no tiene padres asignados aún', style: TextStyle(color: Colors.grey, fontSize: 12),)),
              ],
            ),
          )
        ],
      ),
    ) : const Center(child: CupertinoActivityIndicator());
  }
}