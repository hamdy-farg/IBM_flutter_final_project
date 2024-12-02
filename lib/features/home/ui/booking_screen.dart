import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/app_text_button.dart';
import 'package:ibm_flutter_final_project/features/User/logic/book_room/book_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/check_in_out.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/booking_photo.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/select_date.dart';
import 'package:intl/intl.dart';

class BookingRoom extends StatelessWidget {
  BookingRoom({super.key});
  final cubit = getIt<BookRoomCubit>();
  String start = "12:00:00";
  String end = "11:00:00";

  String formatTime(String time) {
    final format = DateFormat("h:mm a"); // 12-hour format with AM/PM
    final parsedTime =
        DateFormat("HH:mm:ss").parse(time); // Parse the 24-hour format
    return format.format(parsedTime); // Format into 12-hour AM/PM format
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 250, width: double.infinity, child: BookingPhoto()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Small Metting Room",
                  style: TextStyles.font22BlackBold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_sharp,
                      color: ColorsManager.mainBlack,
                    ),

                    horizantalSpace(5),
                    // !

                    Text(
                      "${formatTime(start)} - ${formatTime(end)}",
                      style: TextStyles.font16LightGreySemiBold,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                  left: 10,
                ),
                width: 100.w,
                height: 50.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.Inactive.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                  color: ColorsManager.lightGrey,
                ),
                child: Center(
                  child: Text(
                    "20 Seats",
                    style: TextStyles.font18WhiteBold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13, top: 15, right: 10),
                child: Text(
                    "Paragraphs are the building blocks of papers. Many students define paragraphs in terms of length: a paragraph is a group of at least five sentences, a paragraph is half a page long, etc. In reality, though, the unity and coherence of ideas among sentences is what constitutes a paragraph.",
                    style: TextStyles.font12LightBlueRegular),
              ),
              verticalSpace(16),
              CustomDatePicker(
                onDatePicked: (val) {
                  log("$val");
                  cubit.selectedDateChange(val);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: CheckInCheckoutWidget(
                  checkInCallback: (val) {
                    log(" checkin -- $val");
                    cubit.checkInHourChange(val);
                  },
                  checkOutCallback: (val) {
                    log(" checkout -- $val");
                    cubit.checkOutHourChange(val);
                  },
                  availableHours: [
                    //!!!! 24 =>  12  19:00:00
                    [1, 5],
                    [7, 10],
                    [11, 17],
                  ], // Time ranges for check-in and check-out
                ),
              ),
              verticalSpace(10),
              Center(
                child: Container(
                  width: 350.w,
                  height: 60.h,
                  child: AppTextButton(
                    buttonText: "Review Booking - EGP 2000",
                    buttonStyle: TextStyles.font20WhiteBold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
