class RemoveEquipmentModel {
  RemoveEquipmentModel({
    required this.message,
    required this.status,
    required this.response,
  });

  String message;
  String status;
  String response;

  factory RemoveEquipmentModel.fromJson(Map<String, dynamic> json) =>
      RemoveEquipmentModel(
        message: json["message"] ?? "",
        status: json["status"],
        response: json["response"] ?? "",
      );
}
