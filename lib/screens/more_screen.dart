import 'package:amazoncloneapp/utils/constants.dart';
import 'package:amazoncloneapp/widgets/category_widget.dart';
import 'package:amazoncloneapp/widgets/searchbar_widget.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(width * 1, height * 0.1),
            child: AppSearchBar(
              width: width,
              height: height,
              hasBackButton: false,
              isReadOnly: true,
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.3 / 3.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: categories.length,
              itemBuilder: (context, index) => CategoryWidget(
                    index: index,
                  )),
        ));
  }
}
