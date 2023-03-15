// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyrentals/common/ui/Ui.dart';
import 'package:qcamyrentals/config/image_links.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import '../../../../../config/colors.dart';
import '../../../../../repository/my_bookings/booking_details/booking_details.notifier.dart';
import '../../../../../repository/my_bookings/booking_details/conform_booking/conform_booking.notifier.dart';
import '../past_bookings/past_bookings.view.dart';

class BookingDetailsView extends StatelessWidget {
  const BookingDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingDetailsData =
        Provider.of<RentalBookingDetailsNotifier>(context, listen: false);
    final conformBookingData =
        Provider.of<ConformBookingNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        title: Text(
          "Details",
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
      body: FutureBuilder(
          future: bookingDetailsData.getRentalBookingDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  OrderItem(
                    orderNumber:
                        bookingDetailsData.rentalBookingDetailsModel.id,
                    orderStatus: bookingDetailsData
                        .rentalBookingDetailsModel.orderStatus,
                    date: bookingDetailsData.rentalBookingDetailsModel.date,
                    productName: bookingDetailsData
                        .rentalBookingDetailsModel.equipmentName,
                    bookingDate: bookingDetailsData
                        .rentalBookingDetailsModel.bookingDate,
                    image: bookingDetailsData
                            .rentalBookingDetailsModel.equipmentImage.isNotEmpty
                        ? bookingDetailsData
                            .rentalBookingDetailsModel.equipmentImage
                        : noImage,
                    address: bookingDetailsData
                        .rentalBookingDetailsModel.customerAddress,
                    customerName: bookingDetailsData
                        .rentalBookingDetailsModel.customerName,
                    customerNumber: bookingDetailsData
                        .rentalBookingDetailsModel.customerNumber,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            url_launcher.launchUrl(Uri.parse(
                                "tel:${bookingDetailsData.rentalBookingDetailsModel.customerNumber}"));
                          },
                          color: Colors.grey,
                          child: Text(
                            "Call Customer",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      conformBookingData.isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : Expanded(
                              child: MaterialButton(
                                onPressed: () async {
                                  if (bookingDetailsData
                                          .rentalBookingDetailsModel
                                          .orderStatus ==
                                      "ordered") {
                                    conformBookingData.bookingId =
                                        bookingDetailsData
                                            .rentalBookingDetailsModel.id;

                                    await conformBookingData.conformBooking();
                                  }
                                },
                                color: primaryColor,
                                child: Text(
                                  bookingDetailsData.rentalBookingDetailsModel
                                              .orderStatus ==
                                          "ordered"
                                      ? "Confirm Booking"
                                      : "Confirmed",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.5,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                      SizedBox(width: 20),
                    ],
                  ),
                  Spacer(),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }),
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key? key,
    required this.orderNumber,
    required this.orderStatus,
    required this.date,
    required this.productName,
    required this.bookingDate,
    required this.image,
    required this.customerName,
    required this.customerNumber,
    required this.address,
  }) : super(key: key);

  final String orderNumber;
  final String date;
  final String productName;
  final String bookingDate;
  final String orderStatus;
  final String image;
  final String customerName;
  final String customerNumber;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: Ui.getBoxDecoration(color: primaryColor),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  image.isNotEmpty ? image : noImage,
                  width: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      width: 100,
                      child: Image.network(noImage),
                    );
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        productName,
                        style: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "Booking date: $bookingDate",
                      style: GoogleFonts.quicksand(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(color: Colors.grey),
            OrderElement(title: "Order#", value: orderNumber),
            SizedBox(height: 5),
            OrderElement(title: "Date", value: date),
            SizedBox(height: 5),
            OrderElement(title: "Name", value: customerName),
            SizedBox(height: 5),
            OrderElement(title: "Phone", value: customerNumber),
            SizedBox(height: 5),
            OrderElement(title: "Address", value: address),
            SizedBox(height: 5),
            OrderElement(title: "Status", value: orderStatus),
          ],
        ));
  }
}
