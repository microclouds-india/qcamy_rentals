// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyrentals/config/image_links.dart';
import 'package:qcamyrentals/repository/equipment_search/equipment_search.notifier.dart';
import 'package:qcamyrentals/repository/view_equipments/remove_item/remove_item.notifier.dart';
import 'package:qcamyrentals/repository/view_equipments/view_item_details/view_item_details.notifier.dart';
import 'package:qcamyrentals/views/home/main/homeTabViews/view_items/view_items.view.dart';

import '../../../../config/colors.dart';
import '../../../../widgets/searchBar.widget.dart';

class SearchEquipmentsView extends StatefulWidget {
  const SearchEquipmentsView({Key? key}) : super(key: key);

  @override
  State<SearchEquipmentsView> createState() => _SearchEquipmentsViewState();
}

class _SearchEquipmentsViewState extends State<SearchEquipmentsView> {

  String searchText = "";

  @override
  Widget build(BuildContext context) {

    final equipmentSearchData = Provider.of<EquipmentSearchNotifier>(context, listen: false);
    final itemData = Provider.of<RentalEquipmentDetailsNotifier>(context, listen: false);
    final removeItemData = Provider.of<RemoveItemNotifier>(context, listen: true);

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              toolbarHeight: 100,
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
              elevation: 5,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.black,
                ),
                onPressed: () {
                  try {
                    Navigator.pop(context);
                  } catch (e) {
                    Navigator.pop(context);
                  }
                },
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: <Widget>[
                    SizedBox(height: 55.0),
                    Container(
                      margin: EdgeInsets.only(left: 55, right: 10),
                      width: double.infinity,
                      child: SearchFieldWidget(
                        // controller: _searchController,
                        readOnly: false,
                        autofocus: true,
                        hintText: "Search Equipments",
                        onChanged: ((value) {
                          searchText = value;

                          setState(() {});
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: FutureBuilder(
            future: equipmentSearchData.searchData(title: searchText),
            builder: (context, snapshot) {
              if (searchText.isEmpty) {
                return Center(
                  child: Text("Search"),
                );
              } else {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ));
                } else {
                  if (snapshot.hasData) {
                    if (equipmentSearchData.equipmentSearchModel.data.isEmpty) {
                      return Center(
                        child: Text("No Data"),
                      );
                    }
                    return ListView.builder(
                      itemCount: equipmentSearchData.equipmentSearchModel.data.length,
                      itemBuilder: (context, index) {
                        return EquipmentsList(
                          equipmentName:
                          equipmentSearchData.equipmentSearchModel.data[index]!.name,
                          image: equipmentSearchData.equipmentSearchModel.data[index]!.image.isNotEmpty
                              ? "https://cashbes.com/photography/${equipmentSearchData.equipmentSearchModel.data[index]!.image}"
                              : noImage,
                          stock: equipmentSearchData.equipmentSearchModel.data[index]!.stock.isNotEmpty
                              ? equipmentSearchData.equipmentSearchModel.data[index]!.stock
                              : "0",
                          onView: () {
                            itemData.rentalEquipmentId = equipmentSearchData.equipmentSearchModel.data[index]!.id;
                            Navigator.of(context).pushNamed("/viewItemDetailsView");
                          },
                          onEdit: () {
                            itemData.rentalEquipmentId = equipmentSearchData.equipmentSearchModel.data[index]!.id;
                            Navigator.of(context).pushNamed("/editItemDetailsView");
                          },
                          onDelete: () {
                            itemData.rentalEquipmentId = equipmentSearchData.equipmentSearchModel.data[index]!.id;
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: Text('Delete Equipment',
                                        style: TextStyle(color: Colors.black)),
                                    content:
                                    Text('Do you want to remove this item?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text('No', style: TextStyle(color: primaryColor),),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await removeItemData
                                              .removeItem(
                                              id: itemData.rentalEquipmentId)
                                              .whenComplete(() {
                                            Navigator.of(context).pop(true);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Item removed successfully")));
                                          }).onError((error, stackTrace) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Something went wrong!")));
                                          });
                                        },
                                        child: Text('Yes', style: TextStyle(color: primaryColor),),
                                      ),
                                    ],
                                  );
                                }));
                          },
                        );
                      },
                    );
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
    );
  }
}
