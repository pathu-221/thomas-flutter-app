import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/user_model.dart';
import 'package:mobile_app/network/rest_apis/auth.dart';
import 'package:mobile_app/utils/common.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:mobile_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  void _registerUser() async {
    Map request = {
      "firstName": firstNameCont.text,
      "lastName": lastNameCont.text,
      "email": emailCont.text,
      "password": passwordCont.text
    };

    UserDataModel? responseData = await register(request);
    if (responseData != null) {
      toast('user registered successfully!');
      finish(context);
    }
  }

  Widget _buildTopWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          child: Image.asset(app_logo),
        ),
        Text(language.createAnAccount, style: boldTextStyle(size: 20)).center(),
        16.height,
      ],
    );
  }

  Widget _buildFormWidget() {
    return Column(
      children: [
        AppTextField(
          textFieldType: TextFieldType.OTHER,
          controller: firstNameCont,
          decoration: inputDecoration(context,
              labelText: language.lblFirstName.capitalizeFirstLetter()),
          suffix: const Icon(CupertinoIcons.person),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.OTHER,
          controller: lastNameCont,
          decoration: inputDecoration(context,
              labelText: language.lblLastName.capitalizeFirstLetter()),
          suffix: const Icon(CupertinoIcons.person),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.EMAIL,
          controller: emailCont,
          decoration: inputDecoration(context, labelText: language.emailLabel),
          suffix: const Icon(Icons.email_outlined),
        ),
        16.height,
        AppTextField(
          textFieldType: TextFieldType.PASSWORD,
          controller: passwordCont,
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
            onPressed: () {},
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
      text: language.signUp.capitalizeFirstLetter(),
      textColor: Colors.white,
      onTap: _registerUser,
      width: context.width(),
    );
  }

  Widget _signInWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(language.alreadyHaveAnAccount),
      16.width,
      TextButton(
          onPressed: () {
            finish(context);
          },
          child: Text(
            language.login.capitalizeFirstLetter(),
            style: boldTextStyle(color: primaryColor),
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
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
                _signInWidget(),
                30.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
