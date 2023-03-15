import 'package:flutter/material.dart';
import 'package:qcamyrentals/models/search_equipments/equipmentSearch.model.dart';
import 'package:qcamyrentals/repository/equipment_search/equipment_search.networking.dart';

class EquipmentSearchNotifier extends ChangeNotifier {
  final EquipmentSearchNetworking _equipmentSearchNetworking = EquipmentSearchNetworking();

  late EquipmentSearchModel equipmentSearchModel;

  Future searchData({required String title}) async {
    try {
      equipmentSearchModel = await _equipmentSearchNetworking.searchData(title: title);

      return equipmentSearchModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
