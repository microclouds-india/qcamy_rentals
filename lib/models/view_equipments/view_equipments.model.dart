class ViewItemsModel {
  ViewItemsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory ViewItemsModel.fromJson(Map<String, dynamic> json) => ViewItemsModel(
        message: json["message"],
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"],
      );
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.descri,
    required this.specifications,
    required this.price,
    required this.renttype,
    required this.stock,
    required this.image,
  });

  String id;
  String name;
  String descri;
  String specifications;
  String price;
  String renttype;
  String stock;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        descri: json["descri"] ?? "",
        specifications: json["specifications"] ?? "",
        price: json["price"] ?? "",
        renttype: json["renttype"] ?? "",
        stock: json["stock"] ?? "",
        image: json["image"] ?? "",
      );
}
