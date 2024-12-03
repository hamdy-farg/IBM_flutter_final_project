import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/app_text_button.dart';
import 'package:ibm_flutter_final_project/features/User/logic/book_room/book_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/logic/availableRoomHours/available_room_hours_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/logic/bookingRoom/booking_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/booking_photo.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/check_in_out.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/select_date.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';

class BookingRoom extends StatelessWidget {
  BookingRoom({super.key});

  final cubit = getIt<BookRoomDataCubit>();
  final Booking = getIt<BookingRoomCubit>();

  @override
  Widget build(BuildContext context) {
    RoomModel? roomModel;
    final arguments = ModalRoute.of(context)?.settings.arguments as RoomModel;
    roomModel = arguments;
    final getAvialableHours = getIt<AvailableRoomHoursCubit>();
    return Scaffold(
      floatingActionButton: Container(
        width: 350.w,
        height: 60.h,
        child: AppTextButton(
          buttonText:
              "Review Booking - EGP ${calculateEarnings(pricePerHour: roomModel.pricePerHour?.round() ?? 1, startTime: roomModel.startTime ?? "", endTime: roomModel.endTime ?? "")}",
          buttonStyle: TextStyles.font20WhiteBold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: BookingPhoto(
                    imageLink: roomModel.imageLink,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  roomModel.title ?? "Small Metting Room",
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
                      "${formatTime(roomModel.startTime ?? "")} - ${formatTime(roomModel.endTime ?? "")}",
                      style: TextStyles.font16LightGreySemiBold,
                    ),

                    Expanded(child: SizedBox()),
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
                            color: ColorsManager.Inactive.withOpacity(0.1),
                            spreadRadius: 4,
                            blurRadius: 4,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12),
                        color: ColorsManager.lightGrey.withOpacity(.1),
                      ),
                      child: Center(
                        child: Text(
                          "${roomModel.pricePerHour} EGP/H",
                          style: TextStyles.font16BlackBold,
                        ),
                      ),
                    ),
                    horizantalSpace(10)
                  ],
                ),
              ),
              Text(
                "   ${roomModel.startDate ?? ""} - ${roomModel.endDate ?? ""}",
                style: TextStyles.font16LightGreySemiBold,
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
                    "${roomModel.capacity} Seats",
                    style: TextStyles.font18WhiteBold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13, top: 15, right: 10),
                child: Text(
                    roomModel.description ??
                        "Paragraphs are the building blocks of papers. Many students define paragraphs in terms of length: a paragraph is a group of at least five sentences, a paragraph is half a page long, etc. In reality, though, the unity and coherence of ideas among sentences is what constitutes a paragraph.",
                    style: TextStyles.font12LightBlueRegular),
              ),
              verticalSpace(16),
              CustomDatePicker(
                startingDate: isStartDateValid(roomModel.startDate ?? "")
                    ? DateTime.parse(roomModel.startDate ?? "")
                    : DateTime.now(),
                onDatePicked: (val) async {
                  log("room id is ${val}");
                  await getIt<AvailableRoomHoursCubit>()
                      .getAvailableHours(val as String, roomModel?.id ?? "");
                  cubit.selectedDateChange(val);
                },
              ),
              BlocBuilder<BookingRoomCubit, BookingRoomState>(
                bloc: Booking,
                builder: (context, state) {
                  return Padding(
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
                        (getAvialableHours is AvailableRoomHoursSuccessState)
                            ? extractHours((getAvialableHours.state
                                    as AvailableRoomHoursSuccessState)
                                .AvailableHoursList)
                            : []
                      ], // Time ranges for check-in and check-out
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
