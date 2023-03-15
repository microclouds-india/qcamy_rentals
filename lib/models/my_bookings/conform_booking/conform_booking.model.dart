class ConformBookingModel {
  ConformBookingModel({
    required this.orderStatus,
    required this.message,
    required this.status,
    required this.response,
  });

  String orderStatus;
  String message;
  String status;
  String response;

  factory ConformBookingModel.fromJson(Map<String, dynamic> json) =>
      ConformBookingModel(
        orderStatus: json["order_status"] ?? "",
        message: json["message"] ?? "",
        status: json["status"],
        response: json["response"] ?? "",
      );
}
