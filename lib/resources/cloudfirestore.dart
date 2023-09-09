import 'dart:typed_data';

import 'package:amazoncloneapp/models/order_request-model.dart';
import 'package:amazoncloneapp/models/product_model.dart';
import 'package:amazoncloneapp/models/review_model.dart';
import 'package:amazoncloneapp/utils/utils.dart';
import 'package:amazoncloneapp/widgets/simpleproducts_listview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/user_details_models.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadNameAndAddressToDatabase(
      {required UserDetailsModels user}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  Future getNameAndAddress() async {
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    UserDetailsModels userModel =
        UserDetailsModels.getModelFromJson(snapshot.data() as dynamic);
    return userModel;
  }

  Future<String> upLoadProductToDatabase({
    required Uint8List? image,
    required String productName,
    required String rawCost,
    required int discount,
    required String sellerName,
    required String sellerUid,
  }) async {
    productName.trim();
    rawCost.trim();
    String output = "Something went wrong";

    if (image != null && productName != " ") {
      try {
        String uid = Utils().getUid();
        String url =
            await uploadimagetoDatabase(image: image, uid: Utils().getUid());
        double cost = double.parse(rawCost);
        cost = cost - (cost * (discount / 100));
        ProductModel product = ProductModel(
            url: url,
            productName: productName,
            cost: cost,
            discount: discount,
            nmofRating: 0,
            rating: 5,
            sellerName: sellerName,
            sellerUid: sellerUid,
            uid: uid);
        await firebaseFirestore
            .collection("products")
            .doc(uid)
            .set(product.getJson());

        output = "Success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make your all the fileds are not empty";
    }

    return output;
  }

  Future<String> uploadimagetoDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("products").child(uid);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }

  Future<List<Widget>> getProductFromDiscount(int discount) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("products")
        .where("discount", isEqualTo: discount)
        .get();
    snap.docs;

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docssnap = snap.docs[i];
      ProductModel model =
          ProductModel.getProductFromJson(json: (docssnap.data() as dynamic));
      children.add(SimpleProductWidget(productModel: model));
    }
    return children;
  }

  Future uploadReviewToDatabase(
      {required String productUid, required ReviewModel model}) async {
    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .collection("reviews")
        .add(model.getJson());
  }

  Future addProductToCart({required ProductModel productModel}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart')
        .doc(productModel.uid)
        .set(productModel.getJson());
  }

  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart')
        .doc(uid)
        .delete();
  }

  Future buyAllItemsInCart({required UserDetailsModels userDetails}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      ProductModel model =
          ProductModel.getProductFromJson(json: snapshot.docs[i].data());
      addProductToOrders(model: model, userDetails: userDetails);
      await deleteProductFromCart(uid: model.uid);
    }
  }

  // Future buyAllItemsInCart(
  //     {required UserDetailsModels userDetailsModels}) async {
  //   QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
  //       .collection('users')
  //       .doc(firebaseAuth.currentUser!.uid)
  //       .collection('cart')
  //       .get();

  //   for (int i = 0; i < snapshot.docs.length; i++) {
  //     ProductModel model =
  //         ProductModel.getProductFromJson(json: snapshot.docs[i].data());
  //     addProductToOrders(model: model, userDetailsModels: userDetailsModels);
  //     await deleteProductFromCart(uid: model.uid);
  //   }
  // }

  // Future addProductToOrders(
  //     {required ProductModel model,
  //     required UserDetailsModels userDetailsModels}) async {
  //   await firebaseFirestore
  //       .collection('users')
  //       .doc(firebaseAuth.currentUser!.uid)
  //       .collection('orders')
  //       .add(model.getJson());
  //   await sendOrderRequest(model: model, userDetailsModels: userDetailsModels);
  // }
  Future addProductToOrders(
      {required ProductModel model,
      required UserDetailsModels userDetails}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(model.getJson());
    await sendOrderRequest(model: model, userDetails: userDetails);
  }

  Future sendOrderRequest(
      {required ProductModel model,
      required UserDetailsModels userDetails}) async {
    OrderRequestModel orderRequestModel = OrderRequestModel(
        orderName: model.productName, buyersAddress: userDetails.address);
    await firebaseFirestore
        .collection("users")
        .doc(model.sellerUid)
        .collection("orderRequests")
        .add(orderRequestModel.getJson());
  }

  // Future sendOrderRequest(
  //     {required ProductModel model,
  //     required UserDetailsModels userDetailsModels}) async {
  //   OrderRequestModel orderRequestModel = OrderRequestModel(
  //     buyersAddress: userDetailsModels.address,
  //     orderName: model.productName,
  //   );
  //   await firebaseFirestore
  //       .collection('users')
  //       .doc(model.sellerUid)
  //       .collection('orderrequests')
  //       .add(
  //         orderRequestModel.getJson(),
  //       );
  // }
}
