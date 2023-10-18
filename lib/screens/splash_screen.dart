import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/screens/main_menu/main_menu_screen.dart';
import 'package:mobile_app/screens/sign_in_and_sign_up/sign_in_screen.dart';
import 'package:mobile_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomSplashScreen extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    4.seconds.delay.then(((value) {
      if (appStore.isLoggedIn) {
        const MainMenuScreen().launch(context, isNewTask: true);
      } else {
        const SignInScreen().launch(context);
      }
    }));

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          splash_screen_bg,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.white.withOpacity(0.8),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Image.asset(app_logo),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
