import 'package:flutter/material.dart';

import 'package:qcamyrentals/models/view_equipments/remove_equipment/delete_equ.model.dart';
import 'package:qcamyrentals/repository/view_equipments/remove_item/remove_item.networking.dart';

class RemoveItemNotifier extends ChangeNotifier {
  final RemoveItemNetworking _removeItemNetworking = RemoveItemNetworking();

  late RemoveEquipmentModel removeEquipmentModel;

  Future removeItem({required String id}) async {
    try {
      removeEquipmentModel =
          await _removeItemNetworking.removeEquipment(id: id);
      notifyListeners();
    } catch (e) {
      return Future.error(e);
    }
    return removeEquipmentModel;
  }
}
