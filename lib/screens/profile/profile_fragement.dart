import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/network/rest_apis/auth.dart';
import 'package:mobile_app/screens/main_menu/save_signature/save_signature_screen.dart';
import 'package:mobile_app/screens/sign_in_and_sign_up/sign_in_screen.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfileFragement extends StatefulWidget {
  const ProfileFragement({super.key});

  @override
  State<ProfileFragement> createState() => _ProfileFragementState();
}

class _ProfileFragementState extends State<ProfileFragement>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleLogout() async {
    await logout();
    SignInScreen().launch(context, isNewTask: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          language.profile,
          style: primaryTextStyle(size: 18, color: Colors.white),
        ),
      ),
      body: Column(children: [
        SettingItemWidget(
          leading: const Icon(Icons.edit_outlined),
          title: language.saveSignatureTitle,
          onTap: () {
            const SaveSignatureScreen().launch(context);
          },
        ),
        SettingItemWidget(
          leading: const Icon(Icons.logout_outlined),
          title: language.logout,
          onTap: () {
            _handleLogout();
          },
        )
      ]),
    );
  }
}
