import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/network/rest_apis/upload_files.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:path/path.dart';
import 'package:nb_utils/nb_utils.dart';

class SaveSignatureScreen extends StatefulWidget {
  const SaveSignatureScreen({super.key});

  @override
  State<SaveSignatureScreen> createState() => _SaveSignatureScreenState();
}

class _SaveSignatureScreenState extends State<SaveSignatureScreen> {
  final control = HandSignatureControl();
  List<ByteData> signatures = [];

  Future<File> byteDataToFile(ByteData byteData) async {
    final Uint8List uint8List = byteData.buffer.asUint8List();
    final tempDir = Directory.systemTemp;

    final tempFileName = DateTime.now().millisecondsSinceEpoch.toString();

    final File tempFile = File(join(tempDir.path, '$tempFileName.jpg'));
    await tempFile.writeAsBytes(uint8List);

    return tempFile;
  }

  void submitSignature(ByteData byteData) async {
    File signatureImage = await byteDataToFile(byteData);
    String? response = await uploadFile(signatureImage, '/user/save-signature');

    if (response != null) {
      toast('Image uploaded at $response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          language.saveSignatureTitle,
          style: primaryTextStyle(size: 18, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                decoration: boxDecorationWithRoundedCorners(
                    border: Border.all(width: 1)),
                width: context.width(),
                height: context.height() / 2,
                child: HandSignature(control: control),
              ),
              for (final signature in signatures)
                Image.memory(Uint8List.view(signature.buffer)),
              Container(
                width: context.width(),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onTap: () {
                          control.clear();
                          setState(() {});
                        },
                        text: language.reset,
                      ),
                    ),
                    8.width,
                    Expanded(
                      child: AppButton(
                        onTap: () async {
                          final picture =
                              await control.toImage(background: Colors.white);
                          if (picture != null) {
                            submitSignature(picture);
                          }
                          setState(() {});
                        },
                        color: primaryColor,
                        textColor: Colors.white,
                        text: language.save,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
