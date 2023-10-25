import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactFragement extends StatefulWidget {
  const ContactFragement({super.key});

  @override
  State<ContactFragement> createState() => _ContactFragementState();
}

class _ContactFragementState extends State<ContactFragement> {
  List<Widget> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          language.contact,
          style: primaryTextStyle(size: 18, color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns
          ),
          children: [
            GestureDetector(
              onTap: () async {
                launchUrl(Uri.parse(FACEBOOK_URL));
              },
              child: Card(
                color: context.cardColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.facebook,
                      size: 54,
                    ),
                    8.height,
                    Text(
                      'Facebook',
                      style: boldTextStyle(size: 18, color: primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await launchUrl(Uri.parse(INSTAGRAM_URL));
              },
              child: Card(
                color: context.cardColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.instagram,
                      size: 54,
                    ),
                    8.height,
                    Text(
                      'Instagram',
                      style: boldTextStyle(size: 18, color: primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await launchUrl(Uri.parse(YOUTUBE_URL));
              },
              child: Card(
                color: context.cardColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.youtube,
                      size: 54,
                    ),
                    8.height,
                    Text(
                      'Youtube',
                      style: boldTextStyle(size: 18, color: primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await launchUrl(Uri.parse(TIKTOK_URL));
              },
              child: Card(
                color: context.cardColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.tiktok,
                      size: 54,
                    ),
                    8.height,
                    Text(
                      'Tik Tok',
                      style: boldTextStyle(size: 18, color: primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await launchUrl(Uri.parse(WEBSITE_URL));
              },
              child: Card(
                color: context.cardColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.globe,
                      size: 54,
                    ),
                    8.height,
                    Text(
                      'Website',
                      style: boldTextStyle(size: 18, color: primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
