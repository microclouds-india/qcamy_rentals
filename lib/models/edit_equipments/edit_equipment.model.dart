class EditEquipmentModel {
  EditEquipmentModel({
    required this.rentalshopId,
    required this.name,
    required this.stock,
    required this.descri,
    required this.specifications,
    required this.price,
    required this.renttype,
    required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
  });

  String rentalshopId;
  String name;
  String stock;
  String descri;
  String specifications;
  String price;
  String renttype;
  String tdate;
  String ttime;
  String message;
  String status;

  factory EditEquipmentModel.fromJson(Map<String, dynamic> json) =>
      EditEquipmentModel(
        rentalshopId: json["rentalshop_id"] ?? "",
        name: json["name"] ?? "",
        stock: json["stock"] ?? "",
        descri: json["descri"] ?? "",
        specifications: json["specifications"] ?? "",
        price: json["price"] ?? "",
        renttype: json["renttype"] ?? "",
        tdate: json["tdate"] ?? "",
        ttime: json["ttime"] ?? "",
        message: json["message"] ?? "",
        status: json["status"] ?? "",
      );
}
