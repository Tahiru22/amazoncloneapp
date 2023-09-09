import 'package:amazoncloneapp/providers/user_Details_provider.dart';
import 'package:amazoncloneapp/resources/cloudfirestore.dart';
import 'package:amazoncloneapp/screens/custom_main_buttons.dart';
import 'package:amazoncloneapp/utils/utils.dart';
import 'package:amazoncloneapp/widgets/loading_widget.dart';
import 'package:amazoncloneapp/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = true;
  int selected = 1;
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  List<int> keysOfDiscount = [0, 70, 60, 50];
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    costController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? SingleChildScrollView(
                child: SizedBox(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              children: [
                                image == null
                                    ? Stack(
                                        children: [
                                          Image.network(
                                            "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
                                            height: screenSize.height / 10,
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                Uint8List? temp =
                                                    await Utils().pickImage();
                                                if (temp != null) {
                                                  setState(() {
                                                    image = temp;
                                                  });
                                                }
                                              },
                                              icon:
                                                  const Icon(Icons.file_upload))
                                        ],
                                      )
                                    : Stack(
                                        children: [
                                          Image.memory(
                                            image!,
                                            height: screenSize.height / 10,
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                Uint8List? temp =
                                                    await Utils().pickImage();
                                                if (temp != null) {
                                                  setState(() {
                                                    image = temp;
                                                  });
                                                }
                                              },
                                              icon:
                                                  const Icon(Icons.file_upload))
                                        ],
                                      ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              height: screenSize.height * 0.7,
                              width: screenSize.width * 0.7,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldWidget(
                                    title: 'Item Name',
                                    controller: nameController,
                                    obscureText: false,
                                    hintText: 'Enter the name of the product',
                                  ),
                                  TextFieldWidget(
                                    title: 'Cost',
                                    controller: costController,
                                    obscureText: false,
                                    hintText: 'Enter the cost of the product',
                                  ),
                                  const Text(
                                    'Discount',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  ListTile(
                                    title: const Text('None'),
                                    leading: Radio(
                                      value: 1,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(() {
                                          selected = i!;
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text('70%'),
                                    leading: Radio(
                                      value: 2,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(() {
                                          selected = i!;
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text('60%'),
                                    leading: Radio(
                                      value: 3,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(() {
                                          selected = i!;
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text('50%'),
                                    leading: Radio(
                                      value: 4,
                                      groupValue: selected,
                                      onChanged: (int? i) {
                                        setState(() {
                                          selected = i!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomMainButton(
                                child: Text(
                                  'Sell',
                                  style: TextStyle(color: Colors.black),
                                ),
                                color: Colors.orange,
                                isLoading: isLoading,
                                onPressed: () async {
                                  String output = await CloudFirestoreClass()
                                      .upLoadProductToDatabase(
                                    image: image,
                                    productName: nameController.text,
                                    rawCost: costController.text,
                                    discount: keysOfDiscount[selected - 1],
                                    sellerName:
                                        Provider.of<UserDetailsProvider>(
                                                context,
                                                listen: false)
                                            .userDetails
                                            .name,
                                    sellerUid:
                                        FirebaseAuth.instance.currentUser!.uid,
                                  );
                                  if (output == "Success") {
                                    Utils().showSnackBar(
                                        context: context,
                                        content: "Posted product successfully");
                                  } else {
                                    Utils().showSnackBar(
                                        context: context, content: output);
                                  }
                                }),
                            CustomMainButton(
                                child: Text(
                                  'Back',
                                  style: TextStyle(color: Colors.black),
                                ),
                                color: Colors.grey,
                                isLoading: false,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ]),
                    ),
                  ),
                ),
              )
            : const LoadingWidget(),
      ),
    );
  }
}
