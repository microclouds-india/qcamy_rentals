import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyrentals/models/view_equipments/view_equipment_details/view_equ_details.model.dart';

class RentalEquipmentDetailsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/view_equipment";

  final client = http.Client();

  late ViewItemDetailsModel viewItemDetailsModel;

  Future<ViewItemDetailsModel> getRentalEquipmentDetails({
    required String id,
  }) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "id": id,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        viewItemDetailsModel = ViewItemDetailsModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return viewItemDetailsModel;
  }
}
