// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qcamyrentals/config/colors.dart';

import 'bookings.view.dart';
import 'diary.view.dart';

class MyBookingsView extends StatelessWidget {
  const MyBookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/filterBookingsView");
              },
              icon: Icon(
                Icons.filter_alt_outlined,
                size: 30,
              ),
            ),
          ],
          bottom: TabBar(indicatorColor: Colors.white, tabs: [
            Tab(
              child: Text(
                "Bookings",
                style: GoogleFonts.openSans(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tab(
              child: Text(
                "My Diary",
                style: GoogleFonts.openSans(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            BookingsView(),
            MyDiaryView(),
          ],
        ),
      ),
    );
  }
}
