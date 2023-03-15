import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyrentals/models/my_bookings/conform_booking/conform_booking.model.dart';

class ConformBookingNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/rentalshop_confirm_booking";

  final client = http.Client();

  late ConformBookingModel conformBookingModel;

  Future<ConformBookingModel> conformBooking({required String id}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "booking_id": id,
        "request": "confirmed",
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        conformBookingModel = ConformBookingModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return conformBookingModel;
  }
}
