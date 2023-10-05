import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/screens/save_signature_screen.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final List<String> items = [
    'Upload receipt',
    'Save signature',
    'My Receipts',
    'Contact'
  ];

  final screens = [null, const SaveSignatureScreen(), null, null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language.lblMainMenu,
            style: boldTextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AppButton(
                          color: primaryColor,
                          text: items[index],
                          textColor: Colors.white,
                          onTap: () {
                            if (screens[index] != null) {
                              screens[index].launch(context);
                            }
                          },
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}