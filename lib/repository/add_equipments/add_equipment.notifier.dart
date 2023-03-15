import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcamyrentals/models/add_equipments/add_equipment.model.dart';
import 'package:qcamyrentals/repository/add_equipments/add_equipment.networking.dart';

class AddEquipmentNotifier extends ChangeNotifier {
  final AddEquipmentNetworking _addEquipmentNetworking = AddEquipmentNetworking();

  bool isLoading = false;

  late AddEquipmentModel addEquipmentModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future addEquipment({
    required String token,
    required List<XFile> imageList,
    required String name,
    required String description,
    required String specifications,
    required String price,
    required String renttype,
    required String stock,
  }) async {
    loading(true);

    try {
      addEquipmentModel = await _addEquipmentNetworking.addEquipment(
        token: token,
        imageList: imageList,
        name: name,
        description: description,
        specifications: specifications,
        price: price,
        renttype: renttype,
        stock: stock,
      );

      loading(false);
      return addEquipmentModel;
    } on Exception {
      //catch late initialization error
      addEquipmentModel = await _addEquipmentNetworking.addEquipment(
        token: token,
        imageList: imageList,
        name: name,
        description: description,
        specifications: specifications,
        price: price,
        renttype: renttype,
        stock: stock,
      );

      loading(false);
      return addEquipmentModel;
    } catch (e) {
      loading(false);
      return Future.error(e.toString());
    }
  }

  // late DeleteImageModel deleteImageModel;
  // Future deleteWorkImage({
  //   required String imageId,
  // }) async {
  //   try {
  //     deleteImageModel = await _uploadWorlImagesNetworking.deleteImage(
  //       imageId: imageId,
  //     );
  //     notifyListeners();
  //     return deleteImageModel;
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }
}
