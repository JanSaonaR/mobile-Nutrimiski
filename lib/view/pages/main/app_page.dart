import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/presenter/chat_presenter.dart';
import 'package:mobile_nutrimiski/presenter/child_presenter.dart';
import 'package:mobile_nutrimiski/presenter/parent_presenter.dart';
import 'package:mobile_nutrimiski/util/colors.dart';
import 'package:mobile_nutrimiski/util/util.dart';
import 'package:mobile_nutrimiski/view/pages/chat/chat_page.dart';
import 'package:mobile_nutrimiski/view/pages/child/child_list_page.dart';
import 'package:mobile_nutrimiski/view/pages/main/home_page.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../domain/local/notification_service.dart';
import '../../../model/entitie/user_session.dart';
import '../../../presenter/category_presenter.dart';
import '../../../provider/bottom_navigation_bar_provider.dart';
import '../../widgets/app/bottom_navigation_bar_doctor_view.dart';
import '../../widgets/app/bottom_navigation_bar_view.dart';
import '../../widgets/app/navigation_drawer_view.dart';
import '../parent/parent_list_page.dart';

class AppPage extends StatefulWidget {

  const AppPage({Key? key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {

  late var _future;

  listenNotifications() => NotificationService.onNotifications.stream.listen((event) { });

  Future<void> initUser() async {
    var client = StreamChat.of(context).client;
    await client.connectUser(
      User(
          id: UserSession().getDni(),
          extraData: {
            "name" : UserSession().getFirstName()
          }
      ),
      client.devToken(UserSession().getDni()).rawValue,);
  }

  @override
  void initState() {
    if(isParent()){
      _future = initUser().whenComplete((){
        Provider.of<ChildPresenter>(context, listen: false).getNutritionist().whenComplete((){
          Provider.of<ChatPresenter>(context, listen: false).initChannels(Provider.of<ChildPresenter>(context, listen: false).getNutritionistDni(), [], StreamChat.of(context).client).whenComplete((){
            Provider.of<ChildPresenter>(context, listen: false).getChildren().whenComplete((){
              Provider.of<CategoryPresenter>(context, listen: false).getAllCategories();
            });
          });
        });
      });
    }
    else{
      _future = initUser().whenComplete((){
        Provider.of<ParentPresenter>(context, listen: false).getParents().whenComplete((){
          Provider.of<ChatPresenter>(context, listen: false).initChannels(UserSession().getDni(), Provider.of<ParentPresenter>(context, listen: false).parents, StreamChat.of(context).client).whenComplete((){
            Provider.of<CategoryPresenter>(context, listen: false).getAllCategories();
          });
        });
      });
    }


    NotificationService.init().whenComplete((){
      listenNotifications();

      if(isParent()){
        NotificationService.showBreakfastScheduledNotification(title: 'Hora de desayunar!', body: 'La comida más importante del día es el desayuno.', time: Time(7, 30, 0));
        NotificationService.showLunchScheduledNotification(title: 'Hora de almorzar!', body: 'Un almuerzo balanceado ayudará al desarrollo de sus hijos.', time: Time(13, 0, 0));
        NotificationService.showDinnerScheduledNotification(title: 'Hora de cenar!', body: 'Complemente bien la alimentación con una buena cena', time: Time(18, 0, 0));
      }
      else{
        NotificationService.cancel();
      }
    });

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
      bottomNavigationBar: isParent() ?
      CustomBottomNavigationBar(
        index: bottomNavigationBarProvider.pageIndex,
        onChangedTab: (index){
          bottomNavigationBarProvider.setPageIndex(index);
        },
      ) : CustomBottomNavigationBarDoctor(
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
                children: [
                  Image.asset('assets/images/logo.png', scale: 5,),
                ],
              ),
            ),
          ),
          Positioned(
            top: 60, left: 25,
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
            top: 140, right: 25, left: 25,
            child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  if(isParent()){
                    return IndexedStack(
                        index: bottomNavigationBarProvider.pageIndex,
                        children: const [
                          HomePage(),
                          ChatPage(),
                          ChildListPage()
                        ]
                    );
                  }
                  else{
                    return IndexedStack(
                        index: bottomNavigationBarProvider.pageIndex,
                        children: const [
                          ParentListPage(),
                          ChatPage(),
                        ]
                    );
                  }
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
