// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyrentals/common/ui/Ui.dart';
import 'package:qcamyrentals/config/colors.dart';
import 'package:qcamyrentals/config/image_links.dart';
import 'package:qcamyrentals/repository/view_equipments/view_all_items/view_equipments.notifier.dart';
import 'package:qcamyrentals/repository/view_equipments/view_item_details/view_item_details.notifier.dart';

import '../../../../../repository/edit_equipments/edit_equipment.notifier.dart';
import '../../../../../repository/view_equipments/remove_item/remove_item.notifier.dart';

class ViewItemsView extends StatelessWidget {
  const ViewItemsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final equipmentsData =
        Provider.of<ViewEquipmentsNotifier>(context, listen: false);
    final itemData = Provider.of<RentalEquipmentDetailsNotifier>(context, listen: false);
    final removeItemData = Provider.of<RemoveItemNotifier>(context, listen: true);

    Provider.of<EditEquipmentNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        title: Text(
          "Equipments",
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/searchEquipmentsView');
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder(
          future: equipmentsData.getAllRentalItems(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (equipmentsData.viewItemsModel.data.isEmpty) {
                return Center(
                  child: Text("No items"),
                );
              } else {
                return ListView.builder(
                  itemCount: equipmentsData.viewItemsModel.data.length,
                  itemBuilder: (context, index) {
                    return EquipmentsList(
                      equipmentName:
                          equipmentsData.viewItemsModel.data[index].name,
                      image: equipmentsData
                              .viewItemsModel.data[index].image.isNotEmpty
                          ? "https://cashbes.com/photography/${equipmentsData.viewItemsModel.data[index].image}"
                          : noImage,
                      stock: equipmentsData
                              .viewItemsModel.data[index].stock.isNotEmpty
                          ? equipmentsData.viewItemsModel.data[index].stock
                          : "0",
                      onView: () {
                        itemData.rentalEquipmentId = equipmentsData.viewItemsModel.data[index].id;
                        Navigator.of(context).pushNamed("/viewItemDetailsView");
                      },
                      onEdit: () {
                        itemData.rentalEquipmentId =
                            equipmentsData.viewItemsModel.data[index].id;
                        Navigator.of(context).pushNamed("/editItemDetailsView");
                      },
                      onDelete: () {
                        itemData.rentalEquipmentId =
                            equipmentsData.viewItemsModel.data[index].id;
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
              }
            }
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }),
    );
  }
}

class EquipmentsList extends StatelessWidget {
  const EquipmentsList({
    Key? key,
    this.image,
    required this.equipmentName,
    required this.stock,
    this.onView,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  final String? image;
  final String equipmentName;
  final String stock;
  final Function()? onView;
  final Function()? onEdit;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Ui.getBoxDecoration(color: primaryColor),
      padding: EdgeInsets.only(right: 10),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            child: SizedBox(
                width: 130,
                height: 130,
                child: CachedNetworkImage(
                  imageUrl: image ??
                      "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
                  placeholder: (context, url) {
                    return Image.network(
                        "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg");
                  },
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) {
                    return Image.network(
                        "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg");
                  },
                )),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  equipmentName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Stock: $stock",
                style: const TextStyle(
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Options(title: "View", onTap: onView),
              SizedBox(
                height: 10,
              ),
              Options(
                title: "Edit",
                onTap: onEdit,
              ),
              SizedBox(
                height: 10,
              ),
              Options(
                title: "Delete",
                onTap: onDelete,
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
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        alignment: Alignment.center,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
      ),
    );
  }
}
