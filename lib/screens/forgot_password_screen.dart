import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/utils/common.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final Key formkey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          language.resetPassword,
          style: boldTextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          child: Column(children: [
            AppTextField(
              textFieldType: TextFieldType.EMAIL,
              decoration:
                  inputDecoration(context, labelText: language.emailLabel),
            ),
            16.height,
            AppButton(
              width: context.width(),
              onTap: () {},
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
