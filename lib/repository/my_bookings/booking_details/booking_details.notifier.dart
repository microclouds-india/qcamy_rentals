import 'package:flutter/material.dart';
import 'package:qcamyrentals/repository/my_bookings/booking_details/booking_details.networking.dart';

import '../../../models/my_bookings/booking_details/booking_details.model.dart';

class RentalBookingDetailsNotifier extends ChangeNotifier {
  final RentalBookingDetailsNetworking _rentalBookingDetailsNetworking =
      RentalBookingDetailsNetworking();

  late String orderId;

  late RentalBookingDetailsModel rentalBookingDetailsModel;
  Future getRentalBookingDetails() async {
    try {
      rentalBookingDetailsModel = await _rentalBookingDetailsNetworking
          .getRentalBookingDetails(id: orderId);
    } catch (e) {
      return Future.error(e);
    }
    return rentalBookingDetailsModel;
  }
}
