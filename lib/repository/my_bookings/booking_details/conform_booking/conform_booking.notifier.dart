import 'package:flutter/material.dart';
import 'package:qcamyrentals/models/my_bookings/conform_booking/conform_booking.model.dart';
import 'package:qcamyrentals/repository/my_bookings/booking_details/conform_booking/conform_booking.networking.dart';

class ConformBookingNotifier extends ChangeNotifier {
  final ConformBookingNetworking _conformBookingNetworking =
      ConformBookingNetworking();

  late String bookingId;

  bool isLoading = false;

  late ConformBookingModel conformBookingModel;
  Future conformBooking() async {
    isLoading = true;
    notifyListeners();
    try {
      conformBookingModel =
          await _conformBookingNetworking.conformBooking(id: bookingId);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.error(e);
    }
    isLoading = false;
    notifyListeners();
    return conformBookingModel;
  }
}
