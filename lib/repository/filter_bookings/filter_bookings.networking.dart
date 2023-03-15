import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/filter_bookings/filter_bookings.model.dart';

class FilterBookingsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/rentalshop_search_booking";

  final client = http.Client();

  late FilterRentalBookingsModel filterBookingsModel;

  Future<FilterRentalBookingsModel> filterBookings(
      {required String token,
      required String startDate,
      required String endDate}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT),
          body: {"token": token, "start_date": startDate, "end_date": endDate});

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        filterBookingsModel = FilterRentalBookingsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return filterBookingsModel;
  }
}
