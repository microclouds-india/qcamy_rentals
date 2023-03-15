import 'package:flutter/material.dart';
import 'package:qcamyrentals/repository/view_equipments/search_equipments/searchEquipmentsView.dart';
import 'package:qcamyrentals/views/authentication/login.view.dart';
import 'package:qcamyrentals/views/home/main.view.dart';
import 'package:qcamyrentals/views/home/main/homeTabViews/add_Items/add_items.view.dart';
import 'package:qcamyrentals/views/home/main/homeTabViews/filter/booking_filter.view.dart';
import 'package:qcamyrentals/views/home/main/homeTabViews/my_bookings/booking_details.view.dart';
import 'package:qcamyrentals/views/home/main/homeTabViews/view_items/view_items.view.dart';

import '../views/home/main/homeTabViews/my_bookings/my_bookings.view.dart';
import '../views/home/main/homeTabViews/my_bookings/search_diary.view.dart';
import '../views/home/main/homeTabViews/past_bookings/past_booking_details.view.dart';
import '../views/home/main/homeTabViews/past_bookings/past_bookings.view.dart';
import '../views/home/main/homeTabViews/view_items/options/edit_item.view.dart';
import '../views/home/main/homeTabViews/view_items/options/view_item.view.dart';
import '../views/splashscreen/splash.view.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/splashView': (context) => const SplashView(),
  '/loginView': (context) => const LoginView(),
  '/mainHomeView': (context) => MainHomeView(),
  '/addItemsView': (context) => const AddItemsView(),
  '/pastBookingsView': (context) => const PastBookingsView(),
  '/myBookingsView': (context) => const MyBookingsView(),
  '/viewItemsView': (context) => const ViewItemsView(),
  '/bookingDetailsView': (context) => const BookingDetailsView(),
  '/pastBookingDetailsView': (context) => const PastBookingDetailsView(),
  '/viewItemDetailsView': (context) => const ViewItemDetailsView(),
  '/editItemDetailsView': (context) => const EditItemDetailsView(),
  '/filterBookingsView': (context) => const BookingFilterView(),
  '/diarySearchView': (context) => const DiarySearchView(),
  '/searchEquipmentsView': (context) => const SearchEquipmentsView(),
};
