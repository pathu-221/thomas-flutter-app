import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/user_model.dart';
import 'package:mobile_app/network/rest_apis/auth.dart';
import 'package:mobile_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:mobile_app/screens/main_menu/main_menu_screen.dart';
import 'package:mobile_app/screens/sign_in_and_sign_up/sign_up_screen.dart';
import 'package:mobile_app/utils/common.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  Widget _buildTopWidget() {
    return Container(
      child: Column(
        children: [
          Text("${language.login}!", style: boldTextStyle(size: 20)).center(),
          16.height,
        ],
      ),
    );
  }

  void _loginUser() async {
    Map request = {"email": emailCont.text, "password": passCont.text};

    UserDataModel? userData = await login(request);
    if (userData != null) {
      toast("Logged in successfully!");
      MainMenuScreen().launch(context, isNewTask: true);
    }
  }

  Widget _buildFormWidget() {
    return Column(
      children: [
        AppTextField(
          textFieldType: TextFieldType.EMAIL,
          controller: emailCont,
          decoration: inputDecoration(context, labelText: language.emailLabel),
          suffix: const Icon(Icons.email_outlined),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.PASSWORD,
          controller: passCont,
          decoration:
              inputDecoration(context, labelText: language.passwordLabel),
          suffixPasswordInvisibleWidget: const Icon(CupertinoIcons.eye_slash),
          suffixPasswordVisibleWidget: const Icon(CupertinoIcons.eye),
        ),
      ],
    );
  }

  Widget _forgotPasswordWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              const ForgotPasswordScreen().launch(context);
            },
            child: Text(
              language.forgotPassword,
              style: boldTextStyle(color: primaryColor),
            ))
      ],
    );
  }

  Widget _loginButtonWidget() {
    return AppButton(
      color: primaryColor,
      text: language.login,
      textColor: Colors.white,
      onTap: _loginUser,
      width: context.width(),
    );
  }

  Widget _signUpWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(language.dontHaveAnAccount),
      16.width,
      TextButton(
          onPressed: () {
            const SignUpScreen().launch(context);
          },
          child: Text(
            language.signUp,
            style: boldTextStyle(color: primaryColor),
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    print('card color ${context.cardColor}');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: context.scaffoldBackgroundColor),
      ),
      body: SizedBox(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (context.height() * 0.05).toInt().height,
                _buildTopWidget(),
                _buildFormWidget(),
                _forgotPasswordWidget(),
                _loginButtonWidget(),
                _signUpWidget(),
                30.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
