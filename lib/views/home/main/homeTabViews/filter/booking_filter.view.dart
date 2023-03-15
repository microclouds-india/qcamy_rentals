// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../config/colors.dart';
import '../../../../../repository/filter_bookings/filter_booking.notifier.dart';
import '../../../../../repository/my_bookings/booking_details/booking_details.notifier.dart';
import '../my_bookings/bookings.view.dart';

class BookingFilterView extends StatefulWidget {
  const BookingFilterView({Key? key}) : super(key: key);

  @override
  State<BookingFilterView> createState() => _BookingFilterViewState();
}

class _BookingFilterViewState extends State<BookingFilterView> {
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  String date1 = "From";
  String date2 = "To";
  Future<void> _selectDate1() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate1,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate1) {
      setState(() {
        selectedDate1 = picked;
        date1 = "${selectedDate1.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectDate2() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate1) {
      setState(() {
        selectedDate2 = picked;
        date2 = "${selectedDate2.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filterBookingsData =
        Provider.of<FilterBookingsNotifier>(context, listen: false);
    final bookingDetailsData =
        Provider.of<RentalBookingDetailsNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        title: Text(
          "Search",
          style: GoogleFonts.openSans(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectDate1();
                  },
                  child: Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2),
                      ),
                      child: Text(
                        date1,
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectDate2();
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                    ),
                    child: Text(
                      date2,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
                future: filterBookingsData.filterBookings(
                    startDate: date1, endDate: date2),
                builder: (context, snapshot) {
                  if (date1 == "From" || date2 == "To") {
                    return Center(
                      child: Text("Please Select Dates"),
                    );
                  } else {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: primaryColor,
                      ));
                    } else {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: filterBookingsData
                                .filterBookingsModel.data.length,
                            itemBuilder: (context, index) {
                              return OrderItem(
                                productName: filterBookingsData
                                    .filterBookingsModel
                                    .data[index]
                                    .equipmentName,
                                image: filterBookingsData
                                    .filterBookingsModel.data[index].photo,
                                bookingDate: filterBookingsData
                                    .filterBookingsModel
                                    .data[index]
                                    .bookingDate,
                                date: filterBookingsData.filterBookingsModel
                                    .data[index].bookingDate,
                                orderNumber: filterBookingsData
                                    .filterBookingsModel.data[index].orderId,
                                orderStatus: filterBookingsData
                                    .filterBookingsModel
                                    .data[index]
                                    .orderStatus,
                                name: filterBookingsData.filterBookingsModel.data[index].name,
                                onTap: () {
                                  bookingDetailsData.orderId =
                                      filterBookingsData.filterBookingsModel
                                          .data[index].orderId;
                                  Navigator.of(context)
                                      .pushNamed("/bookingDetailsView");
                                },
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Center(child: Text("No Data Found"));
                      }
                    }
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
