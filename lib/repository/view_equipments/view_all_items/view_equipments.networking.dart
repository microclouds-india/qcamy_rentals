import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/view_equipments/view_equipments.model.dart';

class ViewEquipmentsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/equipments";

  final client = http.Client();

  late ViewItemsModel viewItemsModel;

  Future<ViewItemsModel> getAllRentalItems({required String token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        viewItemsModel = ViewItemsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return viewItemsModel;
  }
}
