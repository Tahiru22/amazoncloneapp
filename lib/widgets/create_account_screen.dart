import 'package:amazoncloneapp/utils/color_themes.dart';
import 'package:amazoncloneapp/utils/constants.dart';
import 'package:flutter/material.dart';

class CreateAccountScreenWidget extends StatelessWidget {
  const CreateAccountScreenWidget({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(),

      padding: EdgeInsets.only(
          left: width * 0.03,
          right: width * 0.03,
          bottom: height * 0.012,
          top: height * 0.045),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [],
      ),
    );
  }
}
