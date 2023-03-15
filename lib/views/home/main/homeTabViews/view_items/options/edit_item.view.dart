// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qcamyrentals/config/colors.dart';

import '../../../../../../repository/edit_equipments/edit_equipment.notifier.dart';
import '../../../../../../repository/rental_shop_profile/profile.notifier.dart';
import '../../../../../../repository/view_equipments/view_item_details/view_item_details.notifier.dart';
import '../../../../../../widgets/booking_button.widget.dart';
import '../../../../../../widgets/booking_form_textfield.widget.dart';

class EditItemDetailsView extends StatefulWidget {
  const EditItemDetailsView({Key? key}) : super(key: key);

  @override
  State<EditItemDetailsView> createState() => _EditItemDetailsViewState();
}

class _EditItemDetailsViewState extends State<EditItemDetailsView> {
  // final ImagePicker imagePicker = ImagePicker();
  // List<XFile>? imageFileList = [];

  // int rentType = 0;

  ValueNotifier<int> rentTypeNotifier = ValueNotifier<int>(0);

  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemPriceController = TextEditingController();
  final TextEditingController itemSpecificationsController =
      TextEditingController();
  final TextEditingController itemDescriptionController =
      TextEditingController();
  final TextEditingController itemStockController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    itemNameController.dispose();
    itemPriceController.dispose();
    itemSpecificationsController.dispose();
    itemDescriptionController.dispose();
    itemStockController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //func to select image from gallery
    // void selectImages() async {
    //   try {
    //     final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    //     if (selectedImages!.isNotEmpty) {
    //       imageFileList!.addAll(selectedImages);
    //     }
    //     // print("Image List Length:" + imageFileList!.length.toString());
    //     setState(() {});
    //   } catch (e) {
    //     // ignore: avoid_print
    //     print(e);
    //   }
    // }
    final itemData =
        Provider.of<RentalEquipmentDetailsNotifier>(context, listen: false);
    final editItemData =
        Provider.of<EditEquipmentNotifier>(context, listen: false);
    final rentalShopProfileData =
        Provider.of<RentalShopProfileNotifier>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text(
            "Edit",
            style: GoogleFonts.openSans(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: itemData.getRentalEquipmentDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
              itemNameController.text =
                  itemData.viewItemDetailsModel.data[0].name;
              itemDescriptionController.text =
                  itemData.viewItemDetailsModel.data[0].descri;
              itemSpecificationsController.text =
                  itemData.viewItemDetailsModel.data[0].specifications;
              itemPriceController.text =
                  itemData.viewItemDetailsModel.data[0].price;
              itemStockController.text =
                  itemData.viewItemDetailsModel.data[0].stock;

              if (itemData.viewItemDetailsModel.data[0].renttype == "Day") {
                rentTypeNotifier.value = 2;
              } else {
                rentTypeNotifier.value = 1;
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 5)),
                      ],
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: [
                        BookingFormTextFields(
                          controller: itemNameController,
                          hint: "Equipment Name",
                          maxLines: 1,
                        ),

                        BookingFormTextFields(
                          controller: itemDescriptionController,
                          hint: "Description",
                          maxLines: 2,
                        ),
                        BookingFormTextFields(
                          controller: itemSpecificationsController,
                          hint: "Specifications",
                          maxLines: 7,
                        ),
                        BookingFormTextFields(
                          controller: itemStockController,
                          hint: "Stock",
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                        ),
                        BookingFormTextFields(
                          controller: itemPriceController,
                          hint: "Price",
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                        ),
                        ValueListenableBuilder(
                            valueListenable: rentTypeNotifier,
                            builder: (context, value, _) {
                              return Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.only(left: 8),
                                width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5)),
                                    ],
                                    border: Border.all(color: Colors.grey.withOpacity(0.05)),
                                  ),
                                child: DropdownButton(
                                    underline: SizedBox(),
                                    iconEnabledColor: primaryColor,
                                    isExpanded: true,
                                    value: rentTypeNotifier.value,
                                    items: [
                                      DropdownMenuItem(
                                        value: 0,
                                        child: Text(
                                          "Rent Type",
                                          style: TextStyle(color: grey, fontSize: 13),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 1,
                                        child: Text("Hourly",
                                          style: TextStyle(fontSize: 13),),
                                      ),
                                      DropdownMenuItem(
                                        value: 2,
                                        child: Text("Daily",
                                          style: TextStyle(fontSize: 13),),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      // rentType = value as int;
                                      // setState(() {});
                                      rentTypeNotifier.value = value as int;
                                    }),
                              );
                            }),

                        //button to select images
                        // Container(
                        //   alignment: Alignment.topLeft,
                        //   padding: EdgeInsets.only(left: 10),
                        //   child: MaterialButton(
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     elevation: 0,
                        //     color: Colors.grey,
                        //     onPressed: () async {
                        //       selectImages();
                        //     },
                        //     child: Text(
                        //       "Add Images",
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ),
                        // ),
                        // //image showing part
                        // Visibility(
                        //   visible: imageFileList!.isNotEmpty ? true : false,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: GridView.builder(
                        //         physics: NeverScrollableScrollPhysics(),
                        //         shrinkWrap: true,
                        //         itemCount: imageFileList!.length,
                        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //             crossAxisSpacing: 5, crossAxisCount: 3),
                        //         itemBuilder: (BuildContext context, int index) {
                        //           return Image.file(
                        //             File(imageFileList![index].path),
                        //             fit: BoxFit.cover,
                        //           );
                        //         }),
                        //   ),
                        // ),
                        //submit button
                        Consumer<EditEquipmentNotifier>(
                            builder: (context, data, _) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10, bottom: 20),
                              child: data.isLoading
                                  ? const Center(
                                      heightFactor: 1,
                                      widthFactor: 1,
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                          color: primaryColor,
                                        ),
                                      ),
                                    )
                                  : BookingButton(
                                      text: "Update",
                                      onTap: () async {
                                        await editItemData.editEquipment(
                                            id: itemData.rentalEquipmentId,
                                            shopId: rentalShopProfileData
                                                .rentalShopProfileModel
                                                .data[0]
                                                .id,
                                            name: itemNameController.text,
                                            descri:
                                                itemDescriptionController.text,
                                            specifications:
                                                itemSpecificationsController.text,
                                            price: itemPriceController.text,
                                            rentType: rentTypeNotifier.value == 1
                                                ? "Hourly"
                                                : "Daily",
                                            stock: itemStockController.text);

                                        try {
                                          if (editItemData
                                                  .editEquipmentModel.status ==
                                              "200") {
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: Colors.green,
                                                    behavior:
                                                        SnackBarBehavior.floating,
                                                    content: Text(
                                                        "Updated Successfully")));
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: Colors.red,
                                                    behavior:
                                                        SnackBarBehavior.floating,
                                                    content: Text(
                                                        "Something went wrong")));
                                          }
                                        } catch (_) {
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                      "Something went wrong")));
                                        }
                                      },
                                    ));
                        }),
                      ],
                    ),
                  ),
                ),
              );
            },),);
  }
}
