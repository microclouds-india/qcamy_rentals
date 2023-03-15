class ViewItemDetailsModel {
  ViewItemDetailsModel({
    required this.message,
    required this.data,
    required this.image,
    required this.status,
  });

  String message;
  List<Datum> data;
  List<Image> image;
  String status;

  factory ViewItemDetailsModel.fromJson(Map<String, dynamic> json) =>
      ViewItemDetailsModel(
        message: json["message"],
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        image: List<Image>.from(
            json["image"]?.map((x) => Image.fromJson(x)) ?? []),
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
  });

  String id;
  String name;
  String descri;
  String specifications;
  String price;
  String renttype;
  String stock;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        descri: json["descri"] ?? "",
        specifications: json["specifications"] ?? "",
        price: json["price"],
        renttype: json["renttype"],
        stock: json["stock"],
      );
}

class Image {
  Image({
    required this.id,
    required this.image,
  });

  String id;
  String image;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        image: json["image"],
      );
}
