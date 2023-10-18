import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class ContactFragement extends StatefulWidget {
  const ContactFragement({super.key});

  @override
  State<ContactFragement> createState() => _ContactFragementState();
}

class _ContactFragementState extends State<ContactFragement> {
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
    );
  }
}
