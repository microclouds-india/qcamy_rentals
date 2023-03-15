import 'package:flutter/material.dart';
import 'package:qcamyrentals/core/token_storage/storage.dart';
import 'package:qcamyrentals/models/my_bookings/my_bookings.model.dart';
import 'package:qcamyrentals/repository/my_bookings/my_bookings.networking.dart';

class MyBookingsNotifier extends ChangeNotifier {
  final MyBookingsNetworking _myBookingsNetworking = MyBookingsNetworking();

  late MyBookingsModel myBookingsModel;

  Future getMyBookings() async {
    try {
      LocalStorage localStorage = LocalStorage();
      var token = await localStorage.getToken();

      myBookingsModel =
          await _myBookingsNetworking.getMyBookings(token: token!);
    } catch (e) {
      return Future.error(e);
    }
    return myBookingsModel;
  }

  Future getPastBookings() async {
    try {
      LocalStorage localStorage = LocalStorage();
      var token = await localStorage.getToken();

      myBookingsModel =
          await _myBookingsNetworking.getPastBookings(token: token!);
    } catch (e) {
      return Future.error(e);
    }
    return myBookingsModel;
  }
}
