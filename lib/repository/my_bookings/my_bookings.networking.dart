import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyrentals/models/my_bookings/my_bookings.model.dart';

class MyBookingsNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late MyBookingsModel myBookingsModel;

  Future<MyBookingsModel> getMyBookings({required String token}) async {
    try {
      final request = await client
          .post(Uri.parse("${urlENDPOINT}rentalshop_all_bookings"), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        myBookingsModel = MyBookingsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return myBookingsModel;
  }

  Future<MyBookingsModel> getPastBookings({required String token}) async {
    try {
      final request = await client
          .post(Uri.parse("${urlENDPOINT}rentalshop_past_bookings"), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        myBookingsModel = MyBookingsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return myBookingsModel;
  }
}
