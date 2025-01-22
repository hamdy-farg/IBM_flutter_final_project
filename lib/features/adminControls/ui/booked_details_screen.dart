import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/adminControls/data/models/book.dart';
import 'package:ibm_flutter_final_project/features/adminControls/logic/cubit/edit_booking_cubit.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/custem_reservation_item.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/display_info.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/sign_in_repo.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/signup_repo.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/logic/getSpecifcRoom/get_spcific_room_state.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/logic/getSpecifcRoom/get_specifc_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/navigationBar/navigation_bar_cubit.dart';

class BookedDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BookModel? bookModel;
    final arguments = ModalRoute.of(context)?.settings.arguments;
    String? role =
        CacheHelper.sharedPreferences.getString(cacheHelperString.role);
    if (arguments is BookModel)
      bookModel = ModalRoute.of(context)?.settings.arguments as BookModel?;
    final cubit = getIt<EditBookingCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.mainWhite,
        title: Text(
          "Booked Details",
          style: TextStyles.font18blackbold,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<GetSpecificRoomCubit, GetSpcificRoomState>(
        bloc: getIt<GetSpecificRoomCubit>(),
        listener: (context, state) {
          if (state is GetSpcificRoomStateSeuccess) {
            state.roomModel.update_booking = true;
            state.roomModel.book_id = bookModel?.id;

            Navigator.pushNamed(context, Routes.bookingRoom,
                arguments: state.roomModel);
          } else if (state is GetSpcificRoomStateFial) {
            CherryToast.error(
              title: Text(state.errorMessage),
            );
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return BlocConsumer<EditBookingCubit, EditBookingState>(
              bloc: cubit,
              listener: (context, state) {
                if (state is EditBookingSuccessState) {
                  context.pop();
                  getIt<NavigationBarCubit>().changeCurrentIndex(2);
                  CherryToast.success(
                    title: Text("your booking edit successfully"),
                  ).show(context);
                }
                if (state is EditBookingFailState) {
                  context.pop();
                  getIt<NavigationBarCubit>().changeCurrentIndex(2);
                  CherryToast.success(
                    title: Text("your booking is removed seccussfully"),
                  ).show(context);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                log("state is ${state}");
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          DisplayInfo(
                            bookModel: bookModel,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (role == "admin") {
                                    bookModel!.status = "approved";
                                    cubit.updateAdmingbooking(bookModel);
                                  } else {
                                    getIt<GetSpecificRoomCubit>()
                                        .fetchSpecificRoom(
                                            bookModel?.roomId ?? "");
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: ReservationButton(
                                    text: role == "admin"
                                        ? 'Approve'
                                        : "edit your bookings",
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  height: 40.h,
                                  width: 385.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: ColorsManager.Inactive,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black87.withOpacity(0.1),
                                          blurRadius: 10,
                                          offset: Offset(5, 5),
                                          spreadRadius: 3,
                                        )
                                      ]),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (role == "admin") {
                                        bookModel!.status = "rejected";

                                        cubit.updateAdmingbooking(bookModel);
                                      } else {
                                        log("booked_id :${bookModel?.id}");
                                        cubit.removeClientbooking(bookModel ??
                                            BookModel(
                                                status: "status",
                                                roomImage: "roomImage"));
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        role == "admin" ? "Reject" : "Remove",
                                        style: TextStyles.font14blackbold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              verticalSpace(20),
                            ],
                          )
                        ],
                      ),
                    ),
                    (state is EditBookingLoadingState ||
                            getIt<GetSpecificRoomCubit>().state
                                is GetSpcificRoomStateLoading)
                        ? Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: ColorsManager.mainBlack.withOpacity(.000001),
                          )
                        : const SizedBox(),
                    (state is EditBookingLoadingState ||
                            getIt<GetSpecificRoomCubit>().state
                                is GetSpcificRoomStateLoading)
                        ? Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      ColorsManager.lightGrey.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(12)),
                              width: 150.w,
                              height: 150.w,
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            ),
                          )
                        : const SizedBox(),
                  ],
                );
              });
        },
      ),
    );
  }
}
