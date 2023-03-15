class AddEquipmentModel {
  AddEquipmentModel({
    required this.rentalshopId,
    required this.name,
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
  String descri;
  String specifications;
  String price;
  String renttype;
  String tdate;
  String ttime;
  String message;
  String status;

  factory AddEquipmentModel.fromJson(Map<String, dynamic> json) =>
      AddEquipmentModel(
        rentalshopId: json["rentalshop_id"],
        name: json["name"],
        descri: json["descri"],
        specifications: json["specifications"],
        price: json["price"],
        renttype: json["renttype"],
        tdate: json["tdate"],
        ttime: json["ttime"],
        message: json["message"],
        status: json["status"],
      );
}
