import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:qcamyrentals/repository/diary/diary.notifier.dart';
import 'package:qcamyrentals/repository/equipment_search/equipment_search.notifier.dart';
import '../repository/add_equipments/add_equipment.notifier.dart';
import '../repository/authentication/auth.notifier.dart';
import '../repository/edit_equipments/edit_equipment.notifier.dart';
import '../repository/filter_bookings/filter_booking.notifier.dart';
import '../repository/my_bookings/booking_details/booking_details.notifier.dart';
import '../repository/my_bookings/booking_details/conform_booking/conform_booking.notifier.dart';
import '../repository/my_bookings/my_bookings.notifier.dart';
import '../repository/rental_shop_profile/profile.notifier.dart';
import '../repository/view_equipments/remove_item/remove_item.notifier.dart';
import '../repository/view_equipments/view_all_items/view_equipments.notifier.dart';
import '../repository/view_equipments/view_item_details/view_item_details.notifier.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<LoginNotifier>(create: (context) => LoginNotifier()),
  ChangeNotifierProvider<RentalShopProfileNotifier>(
      create: (context) => RentalShopProfileNotifier()),
  ChangeNotifierProvider<AddEquipmentNotifier>(
      create: (context) => AddEquipmentNotifier()),
  ChangeNotifierProvider<MyBookingsNotifier>(
      create: (context) => MyBookingsNotifier()),
  ChangeNotifierProvider<ViewEquipmentsNotifier>(
      create: (context) => ViewEquipmentsNotifier()),
  ChangeNotifierProvider<RentalEquipmentDetailsNotifier>(
      create: (context) => RentalEquipmentDetailsNotifier()),
  ChangeNotifierProvider<RemoveItemNotifier>(
      create: (context) => RemoveItemNotifier()),
  ChangeNotifierProvider<RentalBookingDetailsNotifier>(
      create: (context) => RentalBookingDetailsNotifier()),
  ChangeNotifierProvider<ConformBookingNotifier>(
      create: (context) => ConformBookingNotifier()),
  ChangeNotifierProvider<FilterBookingsNotifier>(
      create: (context) => FilterBookingsNotifier()),
  ChangeNotifierProvider<EditEquipmentNotifier>(
      create: (context) => EditEquipmentNotifier()),
  ChangeNotifierProvider<DiaryNotifier>(
    create: (context) => DiaryNotifier(),
  ),
  ChangeNotifierProvider<EquipmentSearchNotifier>(create: (context) => EquipmentSearchNotifier()),
];
