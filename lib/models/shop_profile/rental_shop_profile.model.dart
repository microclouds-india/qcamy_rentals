class RentalShopProfileModel {
  RentalShopProfileModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory RentalShopProfileModel.fromJson(Map<String, dynamic> json) =>
      RentalShopProfileModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
      );
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.shopNumber,
    required this.username,
    required this.password,
    required this.image,
    required this.location,
    required this.ownerName,
    required this.description,
  });

  String id;
  String name;
  String shopNumber;
  String username;
  String password;
  String image;
  String location;
  String ownerName;
  String description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"],
      name: json["name"],
      shopNumber: json["shop_number"],
      username: json["username"],
      password: json["password"],
      image: json["image"],
      location: json["location"],
      ownerName: json["owner_name"],
      description: json["description"]);
}
