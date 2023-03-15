// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyrentals/repository/my_bookings/booking_details/booking_details.notifier.dart';

import '../../../../../config/colors.dart';
import '../../../../../repository/diary/diary.notifier.dart';
import 'bookings.view.dart';

class DiarySearchView extends StatefulWidget {
  const DiarySearchView({Key? key}) : super(key: key);

  @override
  State<DiarySearchView> createState() => _DiarySearchViewState();
}

class _DiarySearchViewState extends State<DiarySearchView> {
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
    final dairyData = Provider.of<DiaryNotifier>(context, listen: false);
    final bookingDetailsData =
        Provider.of<RentalBookingDetailsNotifier>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 1,
          title: Text(
            "Search Diary",
            style: GoogleFonts.openSans(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
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
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2),
                      ),
                      child: Text(
                        date2,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     Icons.search,
                //     color: primaryColor,
                //     size: 35,
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                  future:
                      dairyData.searchDiary(startDate: date1, endDate: date2),
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
                              itemCount: dairyData.searchDiaryModel.data.length,
                              itemBuilder: (context, index) {
                                return OrderItem(
                                  productName: dairyData
                                      .diaryModel.data[index].equipmentName,
                                  image: dairyData.diaryModel.data[index].photo,
                                  bookingDate: dairyData
                                      .diaryModel.data[index].bookingDate,
                                  date: dairyData.diaryModel.data[index].date,
                                  orderNumber:
                                      dairyData.diaryModel.data[index].orderId,
                                  orderStatus: dairyData.diaryModel.data[index].orderStatus,
                                  name: dairyData.diaryModel.data[index].name,
                                  onTap: () {
                                    bookingDetailsData.orderId = dairyData
                                        .diaryModel.data[index].orderId;
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
        ));
  }
}
