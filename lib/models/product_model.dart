class ProductModel {
  final String url;
  final String productName;
  final double cost;
  final int discount;
  final String uid;
  final String sellerName;
  final String sellerUid;
  final int rating;
  final int nmofRating;

  ProductModel(
      {required this.url,
      required this.productName,
      required this.cost,
      required this.discount,
      required this.nmofRating,
      required this.rating,
      required this.sellerName,
      required this.sellerUid,
      required this.uid});

  Map<String, dynamic> getJson() {
    return {
      "url": url,
      "productName": productName,
      "cost": cost,
      "discount": discount,
      "nmofRating": nmofRating,
      "rating": rating,
      "sellerName": sellerName,
      "sellerUid": sellerUid,
      "uid": uid
    };
  }

  factory ProductModel.getProductFromJson(
      {required Map<String, dynamic> json}) {
    return ProductModel(
        url: json["url"],
        productName: json["productName"],
        cost: json["cost"],
        discount: json["discount"],
        nmofRating: json["nmofRating"],
        rating: json["rating"],
        sellerName: json["sellerName"],
        sellerUid: json["sellerUid"],
        uid: json["uid"]);
  }
}
