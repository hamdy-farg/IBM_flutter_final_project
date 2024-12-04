import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/app_text_button.dart';
import 'package:ibm_flutter_final_project/features/User/logic/book_room/book_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/User/logic/book_room/book_room_state.dart';
import 'package:ibm_flutter_final_project/features/home/data/model/Booking_model.dart';
import 'package:ibm_flutter_final_project/features/home/logic/availableRoomHours/available_room_hours_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/logic/bookingRoom/booking_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/logic/homeCubit/home_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/logic/homeRomesCubit/hoom_rooms_cubit.dart';
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
      floatingActionButton: BlocBuilder<BookRoomDataCubit, BookRoomState>(
        bloc: cubit,
        builder: (context, state) {
          log("messagebbb");
          return GestureDetector(
            onTap: () async {
              if (state.checkInHour != null &&
                  state.checkOutHour != null &&
                  state.selectedDate != null) {
                await getIt<BookingRoomCubit>().makeBooking(
                    UserBookingModel(
                      roomId: roomModel?.id,
                      price: calculateEarnings(
                              pricePerHour: roomModel?.pricePerHour != null
                                  ? roomModel!.pricePerHour!.round()
                                  : 0,
                              startTime: cubit.state.checkInHour != null
                                  ? cubit.state.checkInHour!
                                  : "00:00:00",
                              endTime: cubit.state.checkOutHour != null
                                  ? cubit.state.checkOutHour!
                                  : "00:00:00")
                          .toDouble(),
                      date: cubit.state.selectedDate,
                      startTime: cubit.state.checkInHour,
                      endTime: cubit.state.checkOutHour,
                    ),
                    context);
              } else {
                CherryToast.error(
                  title: Text("you have to choose date start and end time"),
                ).show(context);
              }
            },
            child: Container(
              width: 350.w,
              height: 60.h,
              child: AppTextButton(
                buttonText:
                    "Review Booking - EGP ${calculateEarnings(pricePerHour: roomModel?.pricePerHour != null ? roomModel!.pricePerHour!.round() : 0, startTime: cubit.state.checkInHour != null ? cubit.state.checkInHour! : "00:00:00", endTime: cubit.state.checkOutHour != null ? cubit.state.checkOutHour! : "00:00:00")}",
                buttonStyle: TextStyles.font20WhiteBold,
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                        BlocListener<BookingRoomCubit, BookingRoomState>(
                          bloc: getIt<BookingRoomCubit>(),
                          listener: (context, state) async {
                            if (state is BookingRoomSuccessState) {
                              CherryToast.success(
                                title: Text("your book is booked success"),
                              ).show(context);
                              context
                                  .pushReplacementNamed(Routes.mainHomeScreen);
                              await getIt<HomeWorkSpaceCubit>().getWorkSpace();
                              await getIt<HomeRoomsCubit>().getRooms();
                            }
                          },
                          child: SizedBox(),
                        ),
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                    padding:
                        const EdgeInsets.only(left: 13, top: 15, right: 10),
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
                      await getIt<AvailableRoomHoursCubit>().getAvailableHours(
                          val as String, roomModel?.id ?? "");
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
                        child: BlocBuilder<AvailableRoomHoursCubit,
                            AvailableRoomHoursState>(
                          bloc: getAvialableHours,
                          builder: (context, state) {
                            return CheckInCheckoutWidget(
                              checkInCallback: (val) {
                                log(" checkin -- $val");
                                cubit.checkInHourChange(val);
                              },
                              checkOutCallback: (val) {
                                log(" checkout -- $val");
                                cubit.checkOutHourChange(val);
                              },
                              availableHours:
                                  //!!!! 24 =>  12  19:00:00
                                  (state is AvailableRoomHoursSuccessState)
                                      ? extractHours((getAvialableHours.state
                                              as AvailableRoomHoursSuccessState)
                                          .AvailableHoursList)
                                      : [
                                          [0, 0]
                                        ], // Time ranges for check-in and check-out
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<BookingRoomCubit, BookingRoomState>(
              bloc: getIt<BookingRoomCubit>(),
              builder: (context, state) {
                return state is BookingRoomLoadingState
                    ? Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: ColorsManager.mainBlack.withOpacity(.000001),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorsManager.lightGrey.withOpacity(.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: 150.w,
                              height: 150.w,
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            ),
                          )
                        ],
                      )
                    : SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
