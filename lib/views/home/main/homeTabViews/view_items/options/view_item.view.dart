// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyrentals/common/ui/Ui.dart';
import 'package:qcamyrentals/repository/view_equipments/view_all_items/view_equipments.notifier.dart';
import 'package:readmore/readmore.dart';

import '../../../../../../config/colors.dart';
import '../../../../../../config/image_links.dart';
import '../../../../../../repository/view_equipments/view_item_details/view_item_details.notifier.dart';
import '../../../../../../widgets/view_image.widget.dart';

class ViewItemDetailsView extends StatelessWidget {
  const ViewItemDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemData = Provider.of<RentalEquipmentDetailsNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Details",
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
      body: FutureBuilder(
          future: itemData.getRentalEquipmentDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              itemData.selectedImage = itemData
                      .viewItemDetailsModel.image.isNotEmpty
                  ? itemData.viewItemDetailsModel.image[0].image
                  : "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg";
              return Container(
                margin: EdgeInsets.all(20.0),
                decoration: Ui.getBoxDecoration(color: primaryColor),
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewImage(imageLink: itemData.selectedImage),
                            // imageLink: itemData
                            //         .viewItemDetailsModel.image.isNotEmpty
                            //     ? itemData.viewItemDetailsModel.image[0].image
                            //     : "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"),
                          ),
                        );
                      },
                      child: Consumer<RentalEquipmentDetailsNotifier>(
                          builder: (context, data, _) {
                        return Container(
                          margin: EdgeInsets.all(50.0),
                          child: CachedNetworkImage(
                            // imageUrl: itemData.viewItemDetailsModel.image.isNotEmpty
                            //     ? itemData.viewItemDetailsModel.image[0].image
                            //     : imgPlaceHolder,
                            imageUrl: itemData.selectedImage,
                            placeholder: (context, url) {
                              return Image.asset(
                                "assets/images/png/place_holder.png",
                              );
                            },
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                  "assets/images/png/place_holder.png");
                            },
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      decoration:
                          Ui.getBoxDecorationProfile(color: primaryColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              itemData.viewItemDetailsModel.data[0].name,
                              style: GoogleFonts.quicksand(fontSize: 17),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "₹${itemData.viewItemDetailsModel.data[0].price}/${itemData.viewItemDetailsModel.data[0].renttype}",
                              style: GoogleFonts.openSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              itemData.viewItemDetailsModel.data[0].stock
                                      .isNotEmpty
                                  ? "Stock: ${itemData.viewItemDetailsModel.data[0].stock}"
                                  : "Stock: 0",
                              style: GoogleFonts.openSans(fontSize: 13),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: SizedBox(
                              width: double.infinity,
                              height: 150,
                              child:
                                  itemData.viewItemDetailsModel.image.isNotEmpty
                                      ? ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: itemData
                                              .viewItemDetailsModel
                                              .image
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 10),
                                              child: EquipmentImage(
                                                  image: itemData
                                                      .viewItemDetailsModel
                                                      .image[index]
                                                      .image, itemData: itemData,),
                                            );
                                          })
                                      : Center(child: Text("no images")),
                            ),
                          ),
                          EquipmentDetails(
                            title: "Description",
                            // details:
                            //     "NIKON D5600 DSLR Camera Body with Single Lens: AF-P DX Nikkor 18-55 MM F/3.5-5.6G VR  (Black),Memory card, DK-25 Rubber Eyecup, BF-1B Body Cap, EN-EL14a Rechargeable Li-ion Battery (with Terminal Cover), AN-DC3 Strap, MH-24 Battery Charger ",
                            details:
                                itemData.viewItemDetailsModel.data[0].descri,
                          ),
                          EquipmentDetails(
                            title: "Specifications",
                            // details:
                            //     "NIKON D5600 DSLR Camera Body with Single Lens,\nAF-P DX Nikkor 18-55 MM F/3.5-5.6G VR  (Black),\nMemory card, DK-25 Rubber Eyecup,\nBF-1B Body Cap, EN-EL14a Rechargeable Li-ion Battery (with Terminal Cover),\nAN-DC3 Strap, MH-24 Battery Charger",
                            details: itemData
                                .viewItemDetailsModel.data[0].specifications,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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

class EquipmentDetails extends StatefulWidget {
  const EquipmentDetails({
    Key? key,
    required this.title,
    required this.details,
  }) : super(key: key);

  final String title;
  final String details;

  @override
  State<EquipmentDetails> createState() => _EquipmentDetailsState();
}

class _EquipmentDetailsState extends State<EquipmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            SizedBox(height: 5),
            ReadMoreText(
              widget.details,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              trimLines: 5,
              colorClickableText: primaryColor,
              trimMode: TrimMode.Line,
              trimCollapsedText: ' Show more',
              trimExpandedText: ' Show less',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

class EquipmentImage extends StatelessWidget {
  const EquipmentImage({
    Key? key,
    required this.image,
    required this.itemData,
  }) : super(key: key);

  final String image;
  final RentalEquipmentDetailsNotifier itemData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: ((context) => ViewImage(imageLink: image))));
        itemData.changeSelectedImage(image);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5)),
          ],
          border: Border.all(color: Colors.grey),
        ),
        padding: EdgeInsets.all(10),
        // margin: EdgeInsets.only(left: 10, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.fill,
            width: 120,
            placeholder: (context, url) {
              return Image.asset(
                "assets/images/png/place_holder.png",
                fit: BoxFit.fill,
                width: 120,
              );
            },
          ),
        ),
      ),
    );
  }
}
