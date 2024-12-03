import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/custem_room_widget.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';

class RoomsCards extends StatelessWidget {
  final List<RoomModel>? roomModel;

  const RoomsCards({this.roomModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h, // Use this only if a fixed height is essential
      width: double.infinity,
      child: roomModel != null && roomModel!.isNotEmpty
          ? ListView.builder(
              physics: const BouncingScrollPhysics(), // Smooth scrolling
              itemCount: roomModel?.length,
              itemBuilder: (context, index) {
                final entry = roomModel![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      context.pushNamed(Routes.singleItemScreen);
                    },
                    child: CustemRoomWidget(
                      imageLink: entry.imageLink ?? "",
                      itemName: entry.title,
                      price: entry.pricePerHour?.toString(),
                      location:
                          "entry.location", // Update this dynamically if needed
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text("No rooms available"),
            ),
    );
  }
}
