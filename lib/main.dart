import 'package:flutter/material.dart';
import 'package:mobile_app/locale/language_de.dart';
import 'package:mobile_app/locale/language_en.dart';
import 'package:mobile_app/locale/languages.dart';
import 'package:mobile_app/screens/splash_screen.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

BaseLanguage language = LanguageDe();

void main() async {
  // debugShowCheckedModeBanner = false;
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RestartAppWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: language.login,
        theme: ThemeData(
          cardColor: Colors.grey.shade200,
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        home: CustomSplashScreen(),
      ),
    );
  }
}
