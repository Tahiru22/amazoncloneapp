import 'package:amazoncloneapp/models/product_model.dart';
import 'package:amazoncloneapp/screens/product_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SimpleProductWidget extends StatelessWidget {
  //final String url;
  final ProductModel productModel;
  const SimpleProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(productModel: productModel),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 0),
          child: Image.network(productModel.url),
        ),
      ),
    );
  }
}
