import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_nutrimiski/view/widgets/app/navigation_drawer_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../model/entitie/child.dart';
import '../../../presenter/child_presenter.dart';
import '../../../presenter/parent_presenter.dart';
import '../../../util/colors.dart';
import '../child/child_detail_page.dart';

class ParentChildListPage extends StatefulWidget {
  const ParentChildListPage({Key? key}) : super(key: key);

  @override
  State<ParentChildListPage> createState() => _ParentChildListPageState();
}

class _ParentChildListPageState extends State<ParentChildListPage> {
  @override
  Widget build(BuildContext context) {

    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const NavigationDrawer(),
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      extendBody: true,
      body: Stack(
        children: [
          Positioned(
            top: 50,
            child: SizedBox(
              width: screenSize.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('LOGO', style: TextStyle(color: secondaryColor, fontSize: 30, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          Positioned(
            top: 50, left: 25,
            child: InkWell(
              onTap: () { _scaffoldKey.currentState!.openDrawer(); },
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: primaryColor,
                child: Icon(Icons.menu, color: Colors.white, size: 30,),
              ),
            ),
          ),
          Positioned(
            top: 140, bottom: 90, right: 25, left: 25,
            child: FutureBuilder(
              future: Provider.of<ParentPresenter>(context, listen: false).getChildrenFromParentId(context),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  if(snapshot.data != null) {

                    List<Child> children = Provider.of<ParentPresenter>(context, listen: false).getParentChildren();

                    return ListView.builder(
                      itemCount: children.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Provider.of<ChildPresenter>(context, listen: false).selectedChild = children[index];
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  children[index].sex.toString() == "H" ?
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
                                      Text(children[index].firstName!, style: const TextStyle(fontWeight: FontWeight.bold),),
                                      Text(children[index].lastName!, style: const TextStyle(color: alternativeTextColor, fontSize: 12)),
                                      Text(children[index].age.toString() + " años", style: const TextStyle(color: alternativeTextColor, fontSize: 12)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    );
                  } else {
                    return Center(child: Text('Este padre aún no ha registrado hijos...'));
                  }
                }
                else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
