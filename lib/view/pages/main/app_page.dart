import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mobile_nutrimiski/presenter/child_presenter.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:mobile_nutrimiski/view/pages/child/child_list_page.dart';
import 'package:provider/provider.dart';

import '../../../provider/bottom_navigation_bar_provider.dart';
import '../../widgets/app/bottom_navigation_bar_view.dart';
import '../../widgets/app/navigation_drawer_view.dart';

class AppPage extends StatefulWidget {

  const AppPage({Key? key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {

  late var _future;

  @override
  void initState() {
    _future = Provider.of<ChildPresenter>(context, listen: false).getChildren();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final bottomNavigationBarProvider = Provider.of<BottomNavigationBarProvider>(context);
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const NavigationDrawer(),
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      extendBody: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        index: bottomNavigationBarProvider.pageIndex,
        onChangedTab: (index){
          bottomNavigationBarProvider.setPageIndex(index);
        },
      ),
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
              future: _future,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  return IndexedStack(
                      index: bottomNavigationBarProvider.pageIndex,
                      children: const [
                        Text('1'),
                        Text('2'),
                        ChildListPage()
                      ]
                  );
                } else {
                  return const Center(child: CupertinoActivityIndicator());
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
