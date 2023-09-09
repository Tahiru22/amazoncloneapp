import 'package:amazoncloneapp/widgets/searchbar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(screenSize.width * 1, screenSize.height * 0.1),
          child: AppSearchBar(
            width: screenSize.width,
            height: screenSize.height,
            isReadOnly: false,
            hasBackButton: true,
          )),
    );
  }
}
