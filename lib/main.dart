import 'package:flutter/material.dart';
import 'package:mobile_app/locale/language_de.dart';
import 'package:mobile_app/locale/language_en.dart';
import 'package:mobile_app/locale/languages.dart';
import 'package:mobile_app/models/user_model.dart';
import 'package:mobile_app/network/rest_apis/auth.dart';
import 'package:mobile_app/screens/splash_screen.dart';
import 'package:mobile_app/store/app_store.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:mobile_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

BaseLanguage language = LanguageDe();
AppStore appStore = AppStore();

void main() async {
  // debugShowCheckedModeBanner = false;
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();

  String? token = getStringAsync(AUTH_TOKEN);
  if (token.isNotEmpty) {
    UserDataModel? userData = await authenticate();

    if (userData != null) {
      appStore.setIsLoggedIn(true);
      appStore.setUserFirstName(userData.firstName!);
      appStore.setUserLastName(userData.lastName!);
    }
  }

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
          iconTheme: const IconThemeData(color: Colors.grey),
          cardColor: Colors.grey.shade200,
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        home: const CustomSplashScreen(),
      ),
    );
  }
}
