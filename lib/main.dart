import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_nutrimiski/presenter/child_presenter.dart';
import 'package:mobile_nutrimiski/presenter/child_register_presenter.dart';
import 'package:mobile_nutrimiski/presenter/register_presenter.dart';
import 'package:mobile_nutrimiski/presenter/user_presenter.dart';
import 'package:mobile_nutrimiski/provider/bottom_navigation_bar_provider.dart';
import 'package:mobile_nutrimiski/view/pages/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterPresenter()),
        ChangeNotifierProvider(create: (context) => UserPresenter()),
        ChangeNotifierProvider(create: (context) => ChildRegisterPresenter()),
        ChangeNotifierProvider(create: (context) => ChildPresenter()),
        ChangeNotifierProvider(create: (context) => BottomNavigationBarProvider()),
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

          home: const SplashPage()
      ),
    );
  }
}
