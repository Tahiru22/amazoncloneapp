import 'package:amazoncloneapp/screens/result_screen.dart';
import 'package:amazoncloneapp/utils/constants.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final int index;
  const CategoryWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultScreen(
                      query: categories[index],
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 1),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(
            children: [
              Image.asset('assets/images/categories/${categories[index]}.png'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  categories[index],
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, letterSpacing: 0.5),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
