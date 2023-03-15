import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyrentals/models/edit_equipments/edit_equipment.model.dart';

class EditEquipmentNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/edit_equipment";

  final client = http.Client();

  late EditEquipmentModel editEquipmentModel;

  Future<EditEquipmentModel> editEquipment(
      {required String id,
      required String shopId,
      required String name,
      required String descri,
      required String specifications,
      required String price,
      required String rentType,
      required String stock}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "id": id,
        "rentalshop_id": shopId,
        "name": name,
        "descri": descri,
        "specifications": specifications,
        "price": price,
        "renttype": rentType,
        "stock": stock,
      });
      // print(id);
      // print(shopId);
      // print(name);
      // print(specifications);
      // print(price);
      // print(rentType);
      // print(stock);

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        editEquipmentModel = EditEquipmentModel.fromJson(response);
        // print(response);

      }
    } catch (e) {
      return Future.error(e);
    }
    return editEquipmentModel;
  }
}
