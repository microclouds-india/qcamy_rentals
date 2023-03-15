import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/my_bookings/booking_details/booking_details.model.dart';

class RentalBookingDetailsNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late RentalBookingDetailsModel rentalBookingDetailsModel;

  Future<RentalBookingDetailsModel> getRentalBookingDetails(
      {required String id}) async {
    try {
      final request = await client
          .post(Uri.parse("${urlENDPOINT}rentalshop_order_details"), body: {
        "order_id": id,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        rentalBookingDetailsModel =
            RentalBookingDetailsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return rentalBookingDetailsModel;
  }
}
