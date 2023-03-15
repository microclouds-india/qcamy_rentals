// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qcamyrentals/common/ui/Ui.dart';
import 'package:qcamyrentals/config/colors.dart';
import 'package:qcamyrentals/repository/add_equipments/add_equipment.notifier.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../../../../../repository/rental_shop_profile/profile.notifier.dart';
import '../../../../../widgets/booking_form_textfield.widget.dart';
import '../../../../../widgets/success_dialogBox.widget.dart';

class AddItemsView extends StatefulWidget {
  const AddItemsView({Key? key}) : super(key: key);

  @override
  State<AddItemsView> createState() => _AddItemsViewState();
}

class _AddItemsViewState extends State<AddItemsView> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  int rentType = 0;

  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemPriceController = TextEditingController();
  final TextEditingController itemSpecificationsController =
      TextEditingController();
  final TextEditingController itemDescriptionController =
      TextEditingController();
  final TextEditingController itemStockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //func to select image from gallery
    void selectImages() async {
      try {
        final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
        if (selectedImages!.isNotEmpty) {
          imageFileList!.addAll(selectedImages);
        }
        // print("Image List Length:" + imageFileList!.length.toString());
        setState(() {});
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }

    final rentalShopProfileData = Provider.of<RentalShopProfileNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Add Equipment",
          style: GoogleFonts.openSans(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.only(left: 5.0, right: 5.0),
            decoration: Ui.getBoxDecoration(color: primaryColor),
            child: Column(
              children: [
                BookingFormTextFields(
                  hint: "Equipment Name",
                  maxLines: 1,
                  controller: itemNameController,
                ),

                BookingFormTextFields(
                  hint: "Description",
                  maxLines: 3,
                  controller: itemDescriptionController,
                ),
                BookingFormTextFields(
                  hint: "Specifications",
                  maxLines: 5,
                  controller: itemSpecificationsController,
                ),
                BookingFormTextFields(
                  hint: "Stock",
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  controller: itemStockController,
                ),
                BookingFormTextFields(
                  hint: "Price",
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  controller: itemPriceController,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.only(left: 10),
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
                      value: rentType,
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
                        rentType = value as int;
                        setState(() {});
                      }),
                ),

                //button to select images
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    color: primaryColor,
                    onPressed: () async {
                      selectImages();
                    },
                    child: Text(
                      "Add Images",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                //image showing part

                ReorderableGridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10, crossAxisCount: 3),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10),
                    onReorder: ((oldIndex, newIndex) {
                      XFile path = imageFileList!.removeAt(oldIndex);
                      imageFileList!.insert(newIndex, path);
                      setState(() {});
                    }),
                    itemCount: imageFileList!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        key: ValueKey(index),
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 2),
                        ),
                        child: Stack(
                          children: [
                            Image.file(
                              File(imageFileList![index].path),
                              fit: BoxFit.cover,
                            ),
                            Visibility(
                              visible: index == 0,
                              child: Container(
                                decoration: BoxDecoration(color: primaryColor),
                                child: Text(
                                  " Main Image ",
                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
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
                //           return Container(
                //             decoration: BoxDecoration(
                //               border: Border.all(color: primaryColor, width: 3),
                //             ),
                //             child: Stack(
                //               children: [
                //                 Image.file(
                //                   File(imageFileList![index].path),
                //                   fit: BoxFit.cover,
                //                 ),
                //                 Visibility(
                //                   visible: index == 0,
                //                   child: Container(
                //                     decoration:
                //                         BoxDecoration(color: primaryColor),
                //                     child: Text(
                //                       "Main Image",
                //                       style: TextStyle(color: Colors.white),
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           );
                //         }),
                //   ),
                // ),
                //submit button
                // Padding(
                //     padding: const EdgeInsets.only(
                //         top: 20, left: 10, right: 10, bottom: 20),
                //     child: BookingButton(
                //       text: "Add",
                //       onTap: () async {},
                //     )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight - 5,
        child: Consumer<AddEquipmentNotifier>(builder: (context, data, _) {
          return data.isLoading
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
              : MaterialButton(
                  onPressed: () async {
                    if (imageFileList!.isNotEmpty) {
                      // LocalStorage localStorage = LocalStorage();
                      // final String? token = await localStorage.getToken();

                      await data.addEquipment(
                        token: rentalShopProfileData.rentalShopProfileModel.data[0].id,
                        imageList: imageFileList!,
                        name: itemNameController.text,
                        specifications: itemSpecificationsController.text,
                        description: itemDescriptionController.text,
                        price: itemPriceController.text,
                        renttype: rentType == 1 ? "Hourly" : "Daily",
                        stock: itemStockController.text,
                      );

                      if (data.addEquipmentModel.status == "200") {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return SuccessDialog(
                                message: "Equipment added successfully",
                                onOkPressed: () {
                                  Navigator.pop(context);

                                  setState(() {
                                    imageFileList!.clear();
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            }));
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            content:
                                Text("Upload failed.Please try again later."),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Add images to upload"),
                        ),
                      );
                    }
                  },
                  color: imageFileList!.isNotEmpty ? primaryColor : Colors.grey,
                  child: Text(
                    "Add",
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2),
                  ),
                );
        }),
      ),
    );
  }
}
