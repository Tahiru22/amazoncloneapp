//import 'package:amazoncloneapp/models/user_details_models.dart';
import 'package:amazoncloneapp/resources/cloudfirestore.dart';
//import 'package:amazoncloneapp/utils/constants.dart';
import 'package:amazoncloneapp/widgets/banner_add_widget.dart';
import 'package:amazoncloneapp/widgets/loading_widget.dart';
import 'package:amazoncloneapp/widgets/product_list_view.dart';
import 'package:amazoncloneapp/widgets/searchbar_widget.dart';
//import 'package:amazoncloneapp/widgets/simpleproducts_listview.dart';
import 'package:amazoncloneapp/widgets/user_Details_bar.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/categories_hozontal_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;

  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  // List<Widget> textChildren = [
  //   SimpleProductWidget(
  //       url: "https://m.media-amazon.com/images/I/11M5KkkmavL._SS70_.png"),
  //   SimpleProductWidget(
  //       url: "https://m.media-amazon.com/images/I/11M5KkkmavL._SS70_.png"),
  //   SimpleProductWidget(
  //       url: "https://m.media-amazon.com/images/I/11M5KkkmavL._SS70_.png"),
  //   SimpleProductWidget(
  //       url: "https://m.media-amazon.com/images/I/11M5KkkmavL._SS70_.png"),
  // ];
  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getData() async {
    List<Widget> temp70 =
        await CloudFirestoreClass().getProductFromDiscount(70);
    List<Widget> temp60 =
        await CloudFirestoreClass().getProductFromDiscount(60);
    List<Widget> temp50 =
        await CloudFirestoreClass().getProductFromDiscount(50);
    List<Widget> temp0 = await CloudFirestoreClass().getProductFromDiscount(0);
    print("everything is done");
    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(width * 1, height * 0.1),
            child: AppSearchBar(
              width: width,
              height: height,
              isReadOnly: true,
              hasBackButton: false,
            )),
        body: discount70 != null &&
                discount60 != null &&
                discount50 != null &&
                discount0 != null
            ? Stack(
                children: [
                  SingleChildScrollView(
                    controller: controller,
                    child: Column(children: [
                      const SizedBox(
                        height: 35,
                      ),
                      CategoriesHorizontalListView(),
                      AddBannerWidget(),
                      ProductShowCaseView(
                          title: 'Upto 70% off', children: discount70!),
                      ProductShowCaseView(
                          title: 'Upto 60% off', children: discount60!),
                      ProductShowCaseView(
                          title: 'Upto 70% off', children: discount50!),
                      ProductShowCaseView(
                          title: 'Explore', children: discount0!),
                    ]),
                  ),
                  UserDetailsBar(
                    offset: offset,
                  )
                ],
              )
            : const LoadingWidget());
  }
}
