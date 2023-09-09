import 'package:amazoncloneapp/models/order_request-model.dart';
import 'package:amazoncloneapp/models/product_model.dart';
import 'package:amazoncloneapp/models/user_details_models.dart';
import 'package:amazoncloneapp/screens/custom_main_buttons.dart';
import 'package:amazoncloneapp/screens/sell_screen.dart';
import 'package:amazoncloneapp/utils/color_themes.dart';
import 'package:amazoncloneapp/utils/constants.dart';
import 'package:amazoncloneapp/widgets/create_account_screen.dart';
import 'package:amazoncloneapp/widgets/product_list_view.dart';
import 'package:amazoncloneapp/widgets/simpleproducts_listview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_Details_provider.dart';
import '../widgets/searchbar_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<Widget>? yourOrders;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size(width * 1, height * 0.1),
            child: AppSearchBar(
              width: width,
              height: height,
              hasBackButton: false,
              isReadOnly: false,
            )),
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              children: [
                IntroductionAccountWidgetScreen(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomMainButton(
                    child:
                        Text("Sign Out", style: TextStyle(color: Colors.black)),
                    color: Colors.orange,
                    isLoading: false,
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomMainButton(
                    child: Text(
                      "Sell",
                      style: TextStyle(color: Colors.black),
                    ),
                    color: yellowColor,
                    isLoading: false,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SellScreen(),
                        ),
                      );
                    },
                  ),
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('orders')
                        .get(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        List<Widget> children = [];
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          ProductModel model = ProductModel.getProductFromJson(
                              json: snapshot.data!.docs[i].data());
                          children
                              .add(SimpleProductWidget(productModel: model));
                        }
                        return ProductShowCaseView(
                            title: 'Your Orders', children: children);
                      }
                    }),
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Order requests',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("orderRequests")
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
                                  OrderRequestModel model =
                                      OrderRequestModel.getModelFromJson(
                                          json: snapshot.data!.docs[index]
                                              .data());
                                  return ListTile(
                                    title: Text(
                                      "Order: ${model.orderName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle:
                                        Text("Address: ${model.buyersAddress}"),
                                    trailing: IconButton(
                                        onPressed: () async {
                                          FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection("orderRequests")
                                              .doc(
                                                  snapshot.data!.docs[index].id)
                                              .delete();
                                        },
                                        icon: Icon(Icons.check)),
                                  );
                                });
                          }
                        }))
              ],
            ),
          ),
        ));
  }
}

class IntroductionAccountWidgetScreen extends StatelessWidget {
  const IntroductionAccountWidgetScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserDetailsModels userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white.withOpacity(0.00001)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hello,  ',
                      style: TextStyle(color: Colors.grey[800], fontSize: 26),
                    ),
                    TextSpan(
                        text: '${userDetails.name}',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 26,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://m.media-amazon.com/images/I/11iTpTDy6TL._SS70_.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
