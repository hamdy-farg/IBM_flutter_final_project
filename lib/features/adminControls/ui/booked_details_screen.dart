import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/adminControls/data/models/book.dart';
import 'package:ibm_flutter_final_project/features/adminControls/logic/cubit/booking_cubit.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/custem_reservation_item.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/widgets/display_info.dart';

class BookedDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BookModel? bookModel;
    final arguments = ModalRoute.of(context)?.settings.arguments;

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
      body: BlocConsumer<EditBookingCubit, EditBookingState>(
          bloc: cubit,
          listener: (context, state) {
            if (state is EditBookingSuccessState) {
              context.pop();
              CherryToast.success(
                title: Text("your booking edit successfully"),
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
                              bookModel!.status = "approved";
                              cubit.updatebooking(bookModel);
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ReservationButton(
                                  text: 'Approve',
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 40.h,
                              width: 385.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: ColorsManager.Inactive,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black87.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: Offset(5, 5),
                                      spreadRadius: 3,
                                    )
                                  ]),
                              child: GestureDetector(
                                onTap: () {
                                  bookModel!.status = "rejected";
                                  cubit.updatebooking(bookModel);
                                },
                                child: Center(
                                  child: Text(
                                    "Reject",
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
                (state is EditBookingLoadingState)
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: ColorsManager.mainBlack.withOpacity(.000001),
                      )
                    : const SizedBox(),
                (state is EditBookingLoadingState)
                    ? Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorsManager.lightGrey.withOpacity(.5),
                              borderRadius: BorderRadius.circular(12)),
                          width: 150.w,
                          height: 150.w,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        ),
                      )
                    : const SizedBox(),
              ],
            );
          }),
    );
  }
}
