import 'package:amazoncloneapp/models/user_details_models.dart';
import 'package:amazoncloneapp/resources/cloudfirestore.dart';
import 'package:flutter/material.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModels userDetails;
  UserDetailsProvider()
      : userDetails =
            UserDetailsModels(name: "Loading...", address: "Loading...");

  Future getData() async {
    userDetails = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}
