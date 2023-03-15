// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyrentals/common/ui/Ui.dart';
import 'package:qcamyrentals/config/colors.dart';
import 'package:qcamyrentals/config/image_links.dart';
import 'package:qcamyrentals/core/token_storage/storage.dart';
import 'package:qcamyrentals/repository/rental_shop_profile/profile.notifier.dart';

import '../main.view.dart';

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rentalShopProfileData =
        Provider.of<RentalShopProfileNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.quicksand(color: Colors.white, letterSpacing: 1.2, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title:
                          Text('Logout', style: TextStyle(color: Colors.black)),
                      content: Text('Do you want to logout from this account?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('No',style: TextStyle(color: primaryColor),),
                        ),
                        TextButton(
                          onPressed: () async {
                            //set to default page
                            MainHomeView.pageIndexNotifier.value = 0;
                            //logout operations
                            LocalStorage localStorage = LocalStorage();
                            await localStorage.deleteToken().whenComplete(() {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/loginView", (route) => false);
                            });
                          },
                          child: Text('Yes',style: TextStyle(color: primaryColor),),
                        ),
                      ],
                    );
                  }));
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: rentalShopProfileData.getRentalShopProfileData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      width: double.infinity,
                      color: primaryColor,
                      height: 200,
                      child: Image.network(
                          rentalShopProfileData.rentalShopProfileModel.data[0]
                                  .image.isNotEmpty
                              ? rentalShopProfileData
                                  .rentalShopProfileModel.data[0].image
                              : noImage,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          noImage,
                          fit: BoxFit.fill,
                        );
                      }),
                    ),
                    Center(
                      child: Text(
                        rentalShopProfileData
                            .rentalShopProfileModel.data[0].name,
                        style: GoogleFonts.quicksand(
                            color: Colors.black,
                            letterSpacing: 1.2,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 15, right: 15),
                      decoration: Ui.getBoxDecoration(color: primaryColor),
                      child: Column(
                        children: [
                          UserInfo(
                            title: "Owner's Name",
                            text: rentalShopProfileData
                                .rentalShopProfileModel.data[0].ownerName,
                            icon: Icons.person,
                          ),
                          UserInfo(
                            title: "Description",
                            text: rentalShopProfileData
                                .rentalShopProfileModel.data[0].description,
                            icon: Icons.description,
                          ),
                          UserInfo(
                              title: "Address",
                              text: rentalShopProfileData
                                  .rentalShopProfileModel.data[0].location,
                              icon: Icons.location_on),
                          UserInfo(
                            title: "Phone No",
                            text: rentalShopProfileData
                                .rentalShopProfileModel.data[0].shopNumber,
                            icon: Icons.call,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    required this.text,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: Ui.getBoxDecorationProfile(color: primaryColor),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 30,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w700, fontSize: 14),
              ),
              SizedBox(
                width: 250,
                child: Text(
                  text,
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
