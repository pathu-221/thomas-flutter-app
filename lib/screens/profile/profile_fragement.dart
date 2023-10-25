import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/network/rest_apis/auth.dart';
import 'package:mobile_app/screens/main_menu/save_signature/save_signature_screen.dart';
import 'package:mobile_app/screens/sign_in_and_sign_up/sign_in_screen.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:mobile_app/widgets/loader_widget.dart';
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

  void _handleDeleteProfile() async {
    showConfirmDialogCustom(
      context,
      onAccept: (value) async {
        appStore.setLoading(true);
        await deleteProfile();
        appStore.setLoading(false);
        SignInScreen().launch(context, isNewTask: true);
      },
      positiveText: language.yes,
      negativeText: language.no,
      title: language.areYouSureYouWantToPerformThisAction,
      primaryColor: dangerColor,
    );
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedScrollView(
            listAnimationType: ListAnimationType.FadeIn,
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              SettingSection(
                title: Text(language.general,
                    style: boldTextStyle(color: primaryColor)),
                headingDecoration:
                    BoxDecoration(color: context.primaryColor.withOpacity(0.1)),
                divider: const Offstage(),
                items: [
                  SettingItemWidget(
                    leading: const Icon(Icons.edit_outlined),
                    title: language.saveSignatureTitle,
                    onTap: () {
                      const SaveSignatureScreen().launch(context);
                    },
                  ),
                  SettingSection(
                    title: Text(language.danger,
                        style: boldTextStyle(color: dangerColor)),
                    headingDecoration:
                        BoxDecoration(color: dangerColor.withOpacity(0.1)),
                    divider: const Offstage(),
                    items: [
                      SettingItemWidget(
                        leading: const Icon(
                          Icons.person_remove_rounded,
                        ),
                        title: language.deleteAccount,
                        onTap: () {
                          _handleDeleteProfile();
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: TextButton(
                      child: Text(
                        language.logout,
                        style: boldTextStyle(size: 18, color: primaryColor),
                      ),
                      onPressed: () {
                        _handleLogout();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          Observer(
            builder: (_) => const LoaderWidget().visible(appStore.isLoading),
          ),
        ],
      ),
    );
  }
}
