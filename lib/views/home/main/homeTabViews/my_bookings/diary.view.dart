// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/colors.dart';
import '../../../../../repository/diary/diary.notifier.dart';
import '../../../../../repository/my_bookings/booking_details/booking_details.notifier.dart';
import 'bookings.view.dart';

class MyDiaryView extends StatelessWidget {
  const MyDiaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dairyData = Provider.of<DiaryNotifier>(context, listen: false);
    final bookingDetailsData =
        Provider.of<RentalBookingDetailsNotifier>(context, listen: false);
    return FutureBuilder(
        future: dairyData.getRentalDiary(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            if (dairyData.diaryModel.data.isNotEmpty) {
              return Scaffold(
                body: ListView.builder(
                    itemCount: dairyData.diaryModel.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return OrderItem(
                        productName:
                            dairyData.diaryModel.data[index].equipmentName,
                        image: dairyData.diaryModel.data[index].photo,
                        bookingDate:
                            dairyData.diaryModel.data[index].bookingDate,
                        date: dairyData.diaryModel.data[index].date,
                        orderNumber: dairyData.diaryModel.data[index].orderId,
                        orderStatus: dairyData.diaryModel.data[index].orderStatus,
                        name: dairyData.diaryModel.data[index].name,
                        onTap: () {
                          bookingDetailsData.orderId =
                              dairyData.diaryModel.data[index].orderId;
                          Navigator.of(context)
                              .pushNamed("/bookingDetailsView");
                        },
                      );
                    }),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/diarySearchView');
                  },
                  backgroundColor: primaryColor,
                  child: Icon(Icons.search),
                ),
              );
            } else {
              return Center(
                child: Text("No past bookings"),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }
          return Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          ));
        }));
    // return TableCalendar(
    //   firstDay: DateTime.utc(2010, 10, 16),
    //   lastDay: DateTime.utc(2030, 3, 14),
    //   focusedDay: DateTime.now(),
    // );
  }
}
