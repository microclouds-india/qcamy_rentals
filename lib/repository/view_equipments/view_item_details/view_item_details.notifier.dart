import 'package:flutter/material.dart';

import 'package:qcamyrentals/repository/view_equipments/view_item_details/view_item_details.networking.dart';

import '../../../models/view_equipments/view_equipment_details/view_equ_details.model.dart';

class RentalEquipmentDetailsNotifier extends ChangeNotifier {
  final RentalEquipmentDetailsNetworking _rentalEquipmentDetailsNetworking =
      RentalEquipmentDetailsNetworking();

  late String rentalEquipmentId;

  late ViewItemDetailsModel viewItemDetailsModel;

  bool isDataLoaded = false;

  Future getRentalEquipmentDetails() async {
    try {
      viewItemDetailsModel = await _rentalEquipmentDetailsNetworking
          .getRentalEquipmentDetails(id: rentalEquipmentId);
      isDataLoaded = true;
      notifyListeners();

      return viewItemDetailsModel;
    } catch (e) {
      return Future.error(e);
    }
  }

  String selectedImage = "";
  changeSelectedImage(var image) {
    selectedImage = image;
    notifyListeners();
  }
}
