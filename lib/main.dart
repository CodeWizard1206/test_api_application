import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_api_application/home_page.dart';
import 'package:test_api_application/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test API Application',
      theme: (DateTime.now().hour <= 15 && DateTime.now().hour >= 6)
          ? ThemeData.light()
          : ThemeData.dark(),
      routes: {
        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(),
      },
      initialRoute: '/',
    );
  }
}
