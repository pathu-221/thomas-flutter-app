import 'package:flutter/material.dart';
import 'package:mobile_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: Loader(
          size: LOADER_SIZE,
        ),
      ),
    );
  }
}
