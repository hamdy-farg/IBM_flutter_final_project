import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/desk_app.dart';
import 'package:ibm_flutter_final_project/features/home/data/model/work_spaces.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/custem_room_widget.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/favourite_icon_changer.dart';

class RoomsCards extends StatefulWidget {
  const RoomsCards({super.key});

  @override
  State<RoomsCards> createState() => _RoomsCardsState();
}

final List<RoomCard> roomCard = [
  RoomCard(
      price: '3.0',
      itemName: 'Titen Office Center',
      imagePath: '',
      location: 'cairo ,nacer city'),
  RoomCard(
      price: '3.0',
      itemName: 'Titen Office Center',
      imagePath: '',
      location: 'cairo ,nacer city'),
  RoomCard(
      price: '3.0',
      itemName: 'Titen Office Center',
      imagePath: '',
      location: 'cairo ,nacer city'),
  RoomCard(
      price: '3.0',
      itemName: 'Titen Office Center',
      imagePath: '',
      location: 'cairo ,nacer city'),
  RoomCard(
      price: '3.0',
      itemName: 'Titen Office Center',
      imagePath: '',
      location: 'cairo ,nacer city'),
  RoomCard(
      price: '3.0',
      itemName: 'Titen Office Center',
      imagePath: '',
      location: 'cairo ,nacer city'),
  RoomCard(
      price: '3.0',
      itemName: 'Titen Office Center',
      imagePath: '',
      location: 'cairo ,nacer city'),
  RoomCard(
      price: '3.0',
      itemName: 'Titen Office Center',
      imagePath: '',
      location: 'cairo ,nacer city'),
  RoomCard(
      price: '3.0',
      itemName: 'Titen Office Center',
      imagePath: '',
      location: 'cairo ,nacer city'),
  RoomCard(
      price: '3.0',
      itemName: 'Titen Office Center',
      imagePath: '',
      location: 'cairo ,nacer city'),
];

class _RoomsCardsState extends State<RoomsCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h, // Add the height constraint directly to the container
      width: double.infinity, // Ensure it spans the full width
      child: ListView.builder(
        itemCount: roomCard.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final entry = roomCard[index];
          return Column(
            children: [
              MaterialButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    context.pushNamed(Routes.singleItemScreen);
                  },
                  child: CustemRoomWidget(
                    itemName: entry.itemName,
                    price: entry.price,
                    location: entry.location,
                  )),
              verticalSpace(20)
            ],
          );
        },
      ),
    );
  }
}
