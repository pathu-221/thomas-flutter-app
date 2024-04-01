import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/network/rest_apis/forgot_password.dart';
import 'package:mobile_app/screens/forgot_password/change_pasword_screen.dart';
import 'package:mobile_app/utils/common.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:mobile_app/widgets/loader_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailCont = TextEditingController();

  void _handleSubmit() async {
    if (!formkey.currentState!.validate()) return;

    Map<String, String> requestBody = {
      "email": emailCont.text,
    };

    appStore.setLoading(true);

    HttpResponseModel response = await forgotPasswordOtp(requestBody);
    toast(response.msg);

    appStore.setLoading(false);

    if (response.status == 1) {
      ChangePasswordScreen(
        email: emailCont.text,
      ).launch(context);
    }
  }

  Widget _topWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            language.resetPassword,
            style: boldTextStyle(size: 25),
          ),
          16.height,
          Text(
            language.resetPasswordCaption,
            style: primaryTextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }

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
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _topWidget(),
                Form(
                  key: formkey,
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 16, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppTextField(
                          controller: emailCont,
                          textFieldType: TextFieldType.EMAIL,
                          decoration: inputDecoration(context,
                              labelText: language.emailLabel),
                        ),
                        16.height,
                        AppButton(
                          width: context.width(),
                          onTap: _handleSubmit,
                          text: language.submit,
                          color: primaryColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Observer(
            builder: (_) => const LoaderWidget().visible(appStore.isLoading),
          ),
        ],
      ),
    );
  }
}
