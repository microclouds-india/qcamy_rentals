import 'package:flutter/material.dart';

import '../../core/token_storage/storage.dart';
import '../../models/filter_bookings/filter_bookings.model.dart';
import 'filter_bookings.networking.dart';

class FilterBookingsNotifier extends ChangeNotifier {
  final FilterBookingsNetworking _filterBookingsNetworking =
      FilterBookingsNetworking();

  late String bookingId;

  late FilterRentalBookingsModel filterBookingsModel;

  Future filterBookings(
      {required String startDate, required String endDate}) async {
    try {
      LocalStorage localStorage = LocalStorage();
      final String? token = await localStorage.getToken();
      filterBookingsModel = await _filterBookingsNetworking.filterBookings(
          token: token!, startDate: startDate, endDate: endDate);

      return filterBookingsModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
