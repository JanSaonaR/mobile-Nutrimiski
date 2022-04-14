import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_nutrimiski/presenter/category_presenter.dart';
import 'package:mobile_nutrimiski/presenter/chat_presenter.dart';
import 'package:mobile_nutrimiski/presenter/child_presenter.dart';
import 'package:mobile_nutrimiski/presenter/child_register_presenter.dart';
import 'package:mobile_nutrimiski/presenter/ingredient_presenter.dart';
import 'package:mobile_nutrimiski/presenter/meal_presenter.dart';
import 'package:mobile_nutrimiski/presenter/nutritional_plan_presenter.dart';
import 'package:mobile_nutrimiski/presenter/parent_presenter.dart';
import 'package:mobile_nutrimiski/presenter/register_presenter.dart';
import 'package:mobile_nutrimiski/presenter/user_presenter.dart';
import 'package:mobile_nutrimiski/provider/bottom_navigation_bar_provider.dart';
import 'package:mobile_nutrimiski/view/pages/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late StreamChatClient client;


  @override
  void initState() {
    client = StreamChatClient(
      '6tmbuq6sekrb',
      logLevel: Level.WARNING,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterPresenter()),
        ChangeNotifierProvider(create: (context) => UserPresenter()),
        ChangeNotifierProvider(create: (context) => ChildRegisterPresenter()),
        ChangeNotifierProvider(create: (context) => ChildPresenter()),
        ChangeNotifierProvider(create: (context) => ParentPresenter()),
        ChangeNotifierProvider(create: (context) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(create: (context) => MealPresenter()),
        ChangeNotifierProvider(create: (context) => IngredientPresenter()),
        ChangeNotifierProvider(create: (context) => CategoryPresenter()),
        ChangeNotifierProvider(create: (context) => NutritionalPlanPresenter()),
        ChangeNotifierProvider(create: (context) => ChatPresenter()),
      ],
      child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          title: 'Nurimiski',
          theme: ThemeData(
              textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
          ),
          builder: (context, child){
            return StreamChat(
              child: child,
              client: client,
            );
          },
          home: const SplashPage()
      ),
    );
  }
}
