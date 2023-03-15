import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyrentals/models/view_equipments/remove_equipment/delete_equ.model.dart';

class RemoveItemNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/equipment_remove";

  final client = http.Client();

  late RemoveEquipmentModel removeEquipmentModel;

  Future<RemoveEquipmentModel> removeEquipment({required String id}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "id": id,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        removeEquipmentModel = RemoveEquipmentModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return removeEquipmentModel;
  }
}
