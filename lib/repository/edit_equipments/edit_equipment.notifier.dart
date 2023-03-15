import 'package:flutter/material.dart';
import 'package:qcamyrentals/models/edit_equipments/edit_equipment.model.dart';

import 'edit_equipment.networking.dart';

class EditEquipmentNotifier extends ChangeNotifier {
  final EditEquipmentNetworking _editEquipmentNetworking =
      EditEquipmentNetworking();

  late EditEquipmentModel editEquipmentModel;

  bool isLoading = false;

  Future editEquipment(
      {required String id,
      required String shopId,
      required String name,
      required String descri,
      required String specifications,
      required String price,
      required String rentType,
      required String stock}) async {
    try {
      isLoading = true;
      notifyListeners();
      // LocalStorage localStorage = LocalStorage();
      // String? token = await localStorage.getToken();
      editEquipmentModel = await _editEquipmentNetworking.editEquipment(
          id: id,
          shopId: shopId,
          name: name,
          descri: descri,
          specifications: specifications,
          price: price,
          rentType: rentType,
          stock: stock);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.error(e);
    }
    isLoading = false;
    notifyListeners();
    return editEquipmentModel;
  }
}
