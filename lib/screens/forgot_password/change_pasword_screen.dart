import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/network/rest_apis/forgot_password.dart';
import 'package:mobile_app/screens/sign_in_and_sign_up/sign_in_screen.dart';
import 'package:mobile_app/utils/common.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email;

  const ChangePasswordScreen({super.key, required this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController otpCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController confirmPasswordCont = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _handleSubmit() async {
    if (!formKey.currentState!.validate()) return;

    Map<String, dynamic> requestBody = {
      "email": widget.email,
      "otp": otpCont.text.toInt(),
      "password": passwordCont.text,
    };

    HttpResponseModel response = await updatePassword(requestBody);

    toast(response.msg);
    if (response.status == 1) {
      SignInScreen().launch(context, isNewTask: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          language.changePassword,
          style: boldTextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          child: Column(children: [
            AppTextField(
              controller: otpCont,
              textFieldType: TextFieldType.NUMBER,
              decoration:
                  inputDecoration(context, labelText: language.otpLabel),
            ),
            16.height,
            AppTextField(
              textFieldType: TextFieldType.PASSWORD,
              controller: passwordCont,
              suffixPasswordInvisibleWidget:
                  const Icon(CupertinoIcons.eye_slash),
              suffixPasswordVisibleWidget: const Icon(CupertinoIcons.eye),
              decoration:
                  inputDecoration(context, labelText: language.passwordLabel),
            ),
            16.height,
            AppTextField(
              textFieldType: TextFieldType.PASSWORD,
              controller: confirmPasswordCont,
              suffixPasswordInvisibleWidget:
                  const Icon(CupertinoIcons.eye_slash),
              suffixPasswordVisibleWidget: const Icon(CupertinoIcons.eye),
              decoration: inputDecoration(context,
                  labelText: language.confirmPasswordLabel),
              validator: (value) {
                if (value == null) {
                  return language.passwordLabel;
                } else if (value != passwordCont.text) {
                  return language.passwordsDoNotMatch;
                }
                return null;
              },
            ),
            16.height,
            AppButton(
              width: context.width(),
              onTap: _handleSubmit,
              text: language.submit,
              color: primaryColor,
              textColor: Colors.white,
            ),
          ]),
        ),
      ),
    );
  }
}
