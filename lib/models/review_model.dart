class ReviewModel {
  final String senderName;
  final String description;
  final int rating;

  ReviewModel(
      {required this.description,
      required this.rating,
      required this.senderName});

  factory ReviewModel.getModelFromJson({required Map<String, dynamic> json}) {
    return ReviewModel(
        description: json["description"],
        rating: json["rating"],
        senderName: json["senderName"]);
  }

  Map<String, dynamic> getJson() =>
      {"senderName": senderName, "description": description, "rating": rating};
}
