class RentalBookingDetailsModel {
  RentalBookingDetailsModel({
    required this.id,
    required this.rentalshopId,
    required this.customerName,
    required this.customerNumber,
    required this.customerAddress,
    required this.shopName,
    required this.shopAddress,
    required this.latitude,
    required this.longitude,
    required this.shopNumber,
    required this.shopImage,
    required this.userId,
    required this.equipmentId,
    required this.equipmentName,
    required this.qty,
    required this.phone,
    required this.address,
    required this.bookingDate,
    required this.date,
    required this.orderStatus,
    required this.price,
    required this.rentType,
    required this.equipmentImage,
    required this.status,
  });

  String id;
  String rentalshopId;
  String customerName;
  String customerNumber;
  String customerAddress;
  String shopName;
  String shopAddress;
  String latitude;
  String longitude;
  String shopNumber;
  String shopImage;
  String userId;
  String equipmentId;
  String equipmentName;
  String qty;
  String phone;
  String address;
  String bookingDate;
  String date;
  String orderStatus;
  String price;
  String rentType;
  String equipmentImage;
  String status;

  factory RentalBookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      RentalBookingDetailsModel(
        id: json["id"],
        rentalshopId: json["rentalshop_id"] ?? "",
        customerName: json["customer_name"] ?? "",
        customerNumber: json["customer_number"] ?? "",
        customerAddress: json["customer_address"] ?? "",
        shopName: json["shop_name"] ?? "",
        shopAddress: json["shop_address"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        shopNumber: json["shop_number"] ?? "",
        shopImage: json["shop_image"] ?? "",
        userId: json["user_id"] ?? "",
        equipmentId: json["equipment_id"] ?? "",
        equipmentName: json["equipment_name"] ?? "",
        qty: json["qty"] ?? "",
        phone: json["phone"] ?? "",
        address: json["address"] ?? "",
        bookingDate: json["booking_date"] ?? "",
        date: json["date"] ?? "",
        orderStatus: json["order_status"] ?? "",
        price: json["price"] ?? "",
        rentType: json["rent_type"] ?? "",
        equipmentImage: json["equipment_image"] ?? "",
        status: json["status"],
      );
}
