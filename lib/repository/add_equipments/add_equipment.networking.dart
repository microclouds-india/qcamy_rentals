import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:qcamyrentals/models/add_equipments/add_equipment.model.dart';

class AddEquipmentNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late AddEquipmentModel addEquipmentModel;

  Future<AddEquipmentModel> addEquipment(
      {required String token,
      required List<XFile>? imageList,
      required String name,
      required String description,
      required String specifications,
      required String price,
      required String renttype,
      required String stock}) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse("${urlENDPOINT}add_equipment"));
      request.fields['rentalshop_id'] = token;
      request.fields['name'] = name;
      request.fields['descri'] = description;
      request.fields['specifications'] = specifications;
      request.fields['price'] = price;
      request.fields['renttype'] = renttype;
      request.fields['stock'] = stock;

      // print(token);
      // print(name);
      // print(specifications);
      // print(description);
      // print(price);
      // print(renttype);

      //add multiple image to the request
      for (var i = 0; i < imageList!.length; i++) {
        request.files.add(
          http.MultipartFile("image[]", imageList[i].readAsBytes().asStream(),
              await imageList[i].length(),
              filename: imageList[i].name),
        );
      }
      var requestResponse = await request.send();

      //to get response/body from the server/ api
      requestResponse.stream.transform(utf8.decoder).listen((value) {
        var jsonResponse = jsonDecode(value) as Map<String, dynamic>;

        if (requestResponse.statusCode == 200) {
          addEquipmentModel = AddEquipmentModel.fromJson(jsonResponse);
          // print(jsonResponse);
        }
      });
      return addEquipmentModel;
    } catch (e) {
      // print(e);
      throw Exception(e);
    }
  }

  // late DeleteImageModel deleteImageModel;
  // Future<DeleteImageModel> deleteImage({required String imageId}) async {
  //   try {
  //     final request =
  //         await client.post(Uri.parse("${urlENDPOINT}workimage_remove"), body: {
  //       "image_id": imageId,
  //     });

  //     if (request.statusCode == 200) {
  //       final response = json.decode(request.body);
  //       deleteImageModel = DeleteImageModel.fromJson(response);
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  //   return deleteImageModel;
  // }
}
