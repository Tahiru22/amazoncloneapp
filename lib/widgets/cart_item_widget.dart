import 'package:amazoncloneapp/models/product_model.dart';
import 'package:amazoncloneapp/resources/cloudfirestore.dart';
import 'package:amazoncloneapp/screens/product_screen.dart';
import 'package:amazoncloneapp/utils/color_themes.dart';
import 'package:amazoncloneapp/utils/utils.dart';
import 'package:amazoncloneapp/widgets/custom_simplerounded_button.dart';
import 'package:amazoncloneapp/widgets/custom_squre_button.dart';
import 'package:amazoncloneapp/widgets/product_information_widget.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  const CartItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(15),
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductScreen(productModel: product)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenSize.width / 3,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.network(product.url),
                      ),
                    ),
                    ProductInformationWidget(
                      productName: product.productName,
                      cost: product.cost,
                      sellerName: product.sellerName,
                    )
                  ],
                ),
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Row(
              children: [
                CustomSquareButton(
                    child: Icon(Icons.remove),
                    color: backgroundColor,
                    onPressed: () {},
                    dimension: 40),
                CustomSquareButton(
                    child: Text('1', style: TextStyle(color: activeCyanColor)),
                    color: Colors.grey[100]!,
                    onPressed: () {},
                    dimension: 40),
                CustomSquareButton(
                    child: Icon(Icons.add),
                    color: backgroundColor,
                    onPressed: () async {
                      await CloudFirestoreClass().addProductToCart(
                          productModel: ProductModel(
                              url: product.url,
                              productName: product.productName,
                              cost: product.cost,
                              discount: product.discount,
                              nmofRating: product.nmofRating,
                              rating: product.rating,
                              sellerName: product.sellerName,
                              sellerUid: product.sellerUid,
                              uid: Utils().getUid()));
                    },
                    dimension: 40),
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomSimpleRoundedButton(
                        onPressed: () async {
                          await CloudFirestoreClass()
                              .deleteProductFromCart(uid: product.uid);
                        },
                        text: "Delete",
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      CustomSimpleRoundedButton(
                        onPressed: () async {},
                        text: "Save for later",
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "See more like this",
                        style: TextStyle(color: activeCyanColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
