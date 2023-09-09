import 'package:amazoncloneapp/models/product_model.dart';
import 'package:amazoncloneapp/widgets/cost_widget.dart';
import 'package:amazoncloneapp/widgets/rating_star_widget.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final ProductModel product;
  const ResultWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              width: screenSize.width / 3,
              child: Image.network(
                product.url,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                product.productName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: screenSize.width / 5,
                    child: FittedBox(
                      child: RatingStarWidget(rating: product.rating),
                    ),
                  ),
                  Text(
                    product.nmofRating.toString(),
                  ),
                ],
              ),
            ),
            CostWidget(color: Colors.grey, cost: product.cost),
          ],
        ),
      ),
    );
  }
}
