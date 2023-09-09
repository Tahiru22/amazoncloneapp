import 'package:amazoncloneapp/models/review_model.dart';
import 'package:amazoncloneapp/models/user_details_models.dart';
import 'package:amazoncloneapp/providers/user_Details_provider.dart';
import 'package:amazoncloneapp/resources/cloudfirestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({super.key, required this.productUid});

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      // initialRating: 1.0,
      // your app's name?
      title: const Text(
        'Type a review for this product',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?

      // your app's logo?

      submitButtonText: 'Send',
      commentHint: 'Type here',
      //onCancelled: () => print('cancelled'),
      onSubmitted: (RatingDialogResponse res) async {
        CloudFirestoreClass().uploadReviewToDatabase(
            productUid: productUid,
            model: ReviewModel(
                description: res.comment,
                rating: res.rating.toInt(),
                senderName:
                    Provider.of<UserDetailsProvider>(context, listen: false)
                        .userDetails
                        .name));
      },
    );
  }
}
