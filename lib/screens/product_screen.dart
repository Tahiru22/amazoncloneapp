import 'package:amazoncloneapp/models/product_model.dart';
import 'package:amazoncloneapp/models/review_model.dart';
import 'package:amazoncloneapp/models/user_details_models.dart';
import 'package:amazoncloneapp/resources/cloudfirestore.dart';
import 'package:amazoncloneapp/screens/custom_main_buttons.dart';
import 'package:amazoncloneapp/utils/color_themes.dart';
import 'package:amazoncloneapp/utils/constants.dart';
import 'package:amazoncloneapp/utils/utils.dart';
import 'package:amazoncloneapp/widgets/cost_widget.dart';
import 'package:amazoncloneapp/widgets/custom_simplerounded_button.dart';
import 'package:amazoncloneapp/widgets/rating_star_widget.dart';
import 'package:amazoncloneapp/widgets/review_dialogue.dart';
import 'package:amazoncloneapp/widgets/review_widget.dart';
import 'package:amazoncloneapp/widgets/searchbar_widget.dart';
import 'package:amazoncloneapp/widgets/user_Details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_Details_provider.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({super.key, required this.productModel});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    SizedBox spaceThings = const SizedBox(
      height: 15,
    );
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(width * 1, height * 0.1),
          child: AppSearchBar(
            width: width,
            height: height,
            hasBackButton: true,
            isReadOnly: true,
          )),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: kAppBarHeight / 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                widget.productModel.sellerName,
                                style: TextStyle(
                                    color: activeCyanColor, fontSize: 16),
                              ),
                            ),
                            Text(widget.productModel.productName),
                          ],
                        ),
                        RatingStarWidget(rating: widget.productModel.rating),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      //height: height / 3,
                      constraints: BoxConstraints(maxHeight: height / 3),

                      child: Image.network(widget.productModel.url),
                    ),
                  ),
                  spaceThings,
                  CostWidget(
                    color: Colors.black,
                    cost: widget.productModel.cost,
                  ),
                  spaceThings,
                  CustomMainButton(
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(color: Colors.black),
                      ),
                      color: Colors.orange,
                      isLoading: true,
                      onPressed: () async {
                        await CloudFirestoreClass().addProductToOrders(
                            model: widget.productModel,
                            userDetails: Provider.of<UserDetailsProvider>(
                                    context,
                                    listen: false)
                                .userDetails);
                        Utils().showSnackBar(context: context, content: 'Done');
                      }),
                  spaceThings,
                  CustomMainButton(
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(color: Colors.black),
                      ),
                      color: Colors.yellow,
                      isLoading: false,
                      onPressed: () async {
                        await CloudFirestoreClass().addProductToCart(
                            productModel: widget.productModel);
                        Utils().showSnackBar(
                            context: context, content: "Added to cart");
                      }),
                  spaceThings,
                  CustomSimpleRoundedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => ReviewDialog(
                                  productUid: widget.productModel.uid,
                                ));
                      },
                      text: 'Add a review for this product.'),
                  SizedBox(
                    height: height,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .doc(widget.productModel.uid)
                          .collection("reviews")
                          .snapshots(),
                      builder: ((context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                ReviewModel model =
                                    ReviewModel.getModelFromJson(
                                        json:
                                            snapshot.data!.docs[index].data());
                                return ReviewWidget(reviewModel: model);
                              });
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const UserDetailsBar(
            offset: 0,
          )
        ],
      ),
    ));
  }
}
