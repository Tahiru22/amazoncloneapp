class UserDetailsModels {
  final String name;
  final String address;

  UserDetailsModels({required this.name, required this.address});

  Map<String, dynamic> getJson() => {
        "name": name,
        "address": address,
      };

  factory UserDetailsModels.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModels(
      name: json["name"],
      address: json["address"],
    );
  }
}
