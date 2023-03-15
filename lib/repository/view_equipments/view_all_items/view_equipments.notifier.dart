import 'package:flutter/material.dart';
import 'package:qcamyrentals/core/token_storage/storage.dart';
import 'package:qcamyrentals/repository/view_equipments/view_all_items/view_equipments.networking.dart';

import '../../../models/view_equipments/view_equipments.model.dart';

class ViewEquipmentsNotifier extends ChangeNotifier {
  final ViewEquipmentsNetworking _equipmentsNetworking =
      ViewEquipmentsNetworking();

  late ViewItemsModel viewItemsModel;

  Future getAllRentalItems() async {
    try {
      LocalStorage localStorage = LocalStorage();
      var token = await localStorage.getToken();

      viewItemsModel =
          await _equipmentsNetworking.getAllRentalItems(token: token!);
    } catch (e) {
      return Future.error(e);
    }
    return viewItemsModel;
  }
}
