import 'package:amazoncloneapp/screens/result_screen.dart';
import 'package:amazoncloneapp/utils/color_themes.dart';
import 'package:flutter/material.dart';

import '../screens/search_screnn.dart';

class AppSearchBar extends StatelessWidget {
  AppSearchBar(
      {super.key,
      required this.width,
      required this.height,
      required this.hasBackButton,
      required this.isReadOnly});

  final double width;
  final double height;
  final bool isReadOnly;
  final bool hasBackButton;

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: const BorderSide(color: Colors.grey, width: 10),
  );
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      // margin: EdgeInsets.symmetric(),
      height: screenSize.height * 0.7,

      padding: EdgeInsets.only(
          left: width * 0.03,
          right: width * 0.03,
          bottom: height * 0.012,
          top: height * 0.045),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        hasBackButton
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              )
            : Container(),
        SizedBox(
          width: screenSize.width * 0.6,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 5))
            ]),
            child: TextField(
              readOnly: isReadOnly,
              onSubmitted: (String query) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(query: query),
                  ),
                );
              },
              onTap: () {
                if (isReadOnly) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                }
              },
              decoration: InputDecoration(
                hintText: 'Seach For Products Here',
                fillColor: Colors.white,
                filled: true,
                border: border,
                focusedBorder: border,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.mic_none_outlined),
        ),
      ]),
    );
  }
}
