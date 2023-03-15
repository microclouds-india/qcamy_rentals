import 'package:flutter/material.dart';
import 'package:qcamyrentals/core/token_storage/storage.dart';
import 'package:qcamyrentals/repository/rental_shop_profile/profile.networking.dart';

import '../../models/shop_profile/rental_shop_profile.model.dart';

class RentalShopProfileNotifier extends ChangeNotifier {
  final RentalShopProfileNetworking _rentalShopProfileNetworking =
      RentalShopProfileNetworking();

  late RentalShopProfileModel rentalShopProfileModel;

  Future getRentalShopProfileData() async {
    try {
      LocalStorage localStorage = LocalStorage();
      var token = await localStorage.getToken();

      rentalShopProfileModel =
          await _rentalShopProfileNetworking.getShopProfileData(token: token!);
    } catch (e) {
      return Future.error(e);
    }
    return rentalShopProfileModel;
  }
}
