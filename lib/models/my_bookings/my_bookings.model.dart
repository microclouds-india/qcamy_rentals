class MyBookingsModel {
  MyBookingsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory MyBookingsModel.fromJson(Map<String, dynamic> json) =>
      MyBookingsModel(
        message: json["message"],
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"],
      );
}

class Datum {
  Datum({
    required this.orderId,
    required this.name,
    required this.rentalshopId,
    required this.bookingDate,
    required this.equipmentId,
    required this.equipmentName,
    required this.price,
    required this.rentType,
    required this.qty,
    required this.address,
    required this.phone,
    required this.orderStatus,
    required this.photo,
    required this.date,
  });

  String orderId;
  String name;
  String rentalshopId;
  String bookingDate;
  String equipmentId;
  String equipmentName;
  String price;
  String rentType;
  String qty;
  String address;
  String phone;
  String orderStatus;
  String photo;
  String date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderId: json["order_id"] ?? "",
        name: json["name"] ?? "",
        rentalshopId: json["rentalshop_id"] ?? "",
        bookingDate: json["booking_date"] ?? "",
        equipmentId: json["equipment_id"] ?? "",
        equipmentName: json["equipment_name"] ?? "",
        price: json["price"] ?? "",
        rentType: json["rent_type"] ?? "",
        qty: json["qty"] ?? "",
        address: json["address"] ?? "",
        phone: json["phone"] ?? "",
        orderStatus: json["order_status"] ?? "",
        photo: json["photo"] ?? "",
        date: json["date"] ?? "",
      );
}
