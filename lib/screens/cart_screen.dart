import 'package:amazoncloneapp/models/product_model.dart';
import 'package:amazoncloneapp/models/user_details_models.dart';
import 'package:amazoncloneapp/providers/user_Details_provider.dart';
import 'package:amazoncloneapp/resources/cloudfirestore.dart';
import 'package:amazoncloneapp/screens/custom_main_buttons.dart';
import 'package:amazoncloneapp/utils/color_themes.dart';
import 'package:amazoncloneapp/utils/constants.dart';
import 'package:amazoncloneapp/utils/utils.dart';
import 'package:amazoncloneapp/widgets/cart_item_widget.dart';
import 'package:amazoncloneapp/widgets/searchbar_widget.dart';
import 'package:amazoncloneapp/widgets/user_Details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 9,
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("cart")
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CustomMainButton(
                                child: Text(
                                  "Loading",
                                  style: TextStyle(color: Colors.black),
                                ),
                                color: yellowColor,
                                isLoading: true,
                                onPressed: () {});
                          } else {
                            return CustomMainButton(
                                child: Text(
                                  "Proceed to buy (${snapshot.data!.docs.length}) items",
                                  style: TextStyle(color: Colors.black),
                                ),
                                color: yellowColor,
                                isLoading: false,
                                onPressed: () async {
                                  await CloudFirestoreClass().buyAllItemsInCart(
                                      userDetails:
                                          Provider.of<UserDetailsProvider>(
                                                  context,
                                                  listen: false)
                                              .userDetails);
                                  Utils().showSnackBar(
                                      context: context, content: 'Done');
                                });
                          }
                        })
                    // child: CustomMainButton(
                    //   child: Text(
                    //     "Proceed to by (n) items",
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    //   color: Colors.yellow,
                    //   isLoading: false,
                    //   onPressed: () {},
                    // ),
                    ),
                Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("cart")
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  ProductModel model =
                                      ProductModel.getProductFromJson(
                                          json: snapshot.data!.docs[index]
                                              .data());
                                  return CartItemWidget(product: model);
                                });
                          }
                        }))
              ],
            ),
            UserDetailsBar(
              offset: 0,
            ),
          ],
        ),
      ),
    );
  }
}
