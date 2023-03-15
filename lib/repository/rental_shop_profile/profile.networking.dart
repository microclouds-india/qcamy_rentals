import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyrentals/models/shop_profile/rental_shop_profile.model.dart';

class RentalShopProfileNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/profile_rentalshop";

  final client = http.Client();

  late RentalShopProfileModel rentalShopProfileModel;

  Future<RentalShopProfileModel> getShopProfileData(
      {required String token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      });
      // print(token);

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        rentalShopProfileModel = RentalShopProfileModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return rentalShopProfileModel;
  }
}
