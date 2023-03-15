// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyrentals/common/ui/Ui.dart';

import '../../../config/colors.dart';
import '../../../repository/rental_shop_profile/profile.notifier.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rentalShopProfileData =
        Provider.of<RentalShopProfileNotifier>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          rentalShopProfileData.rentalShopProfileModel.data[0].name,
          style: GoogleFonts.quicksand(
              fontSize: 17, color: Colors.white, letterSpacing: 1.2, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Options(
                icon: "my_bookings_icon.png",
                title: "My Bookings",
                onTap: () {
                  Navigator.of(context).pushNamed("/myBookingsView");
                },
              ),
              Options(
                icon: "past_bookings_icon.png",
                title: "Past Bookings",
                onTap: () {
                  Navigator.of(context).pushNamed("/pastBookingsView");
                },
              ),
            ],
          ),
          Row(
            children: [
              Options(
                icon: "add_items.png",
                title: "Add Equipments",
                onTap: () {
                  Navigator.of(context).pushNamed("/addItemsView");
                },
              ),
              Options(
                icon: "view_items.png",
                title: "View Equipments",
                onTap: () {
                  Navigator.of(context).pushNamed("/viewItemsView");
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Options extends StatelessWidget {
  const Options({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String icon;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 200,
        decoration: Ui.getBoxDecoration(color: primaryColor),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("assets/images/png/$icon", height: 50),
          SizedBox(height: 30),
          SizedBox(
            width: 200,
            child: Text(
              title,
              style: GoogleFonts.openSans(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    ));
  }
}
