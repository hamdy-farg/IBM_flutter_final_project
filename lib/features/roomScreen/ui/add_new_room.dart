import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/map_luncher_button.dart';
import 'package:ibm_flutter_final_project/core/widgets/app_text_button.dart';
import 'package:ibm_flutter_final_project/core/widgets/date_picker.dart';
import 'package:ibm_flutter_final_project/core/widgets/image_picker.dart';
import 'package:ibm_flutter_final_project/core/widgets/open_in_google_map.dart';
import 'package:ibm_flutter_final_project/core/widgets/textfield_with_label.dart';
import 'package:ibm_flutter_final_project/core/widgets/time_picker.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/data/models/room_model.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/logic/addNewRoomCubit/add_new_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/roomScreen/logic/addNewRoomCubit/add_new_room_state.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';

class AddNewRoom extends StatelessWidget {
  AddNewRoom({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController capacityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<AddNewRoomCubit>();

    RoomModel? roomModel;
    WorkSpaceModel? workSpace;
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is RoomModel) {
      roomModel = arguments;
      cubit.readyToEdit(roomModel);
    } else if (arguments is WorkSpaceModel) {
      workSpace = arguments;
    }

    FocusNode titleNode = FocusNode();
    FocusNode capacityNode = FocusNode();
    FocusNode decriptionNode = FocusNode();
    FocusNode pricePerHourFocusNode = FocusNode();

    DateTime temp = DateTime.now();
    DateTime tomorrow = temp.add(const Duration(days: 1)); // Add 1 day
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AddNewRoomCubit, RoomState>(
          listener: (context, state) {
            if (state.room != null) {
              context.pop();
              // getIt<AdminRoomsCubit>()
              //     .fetchRooms(workSpace != null ? workSpace.id : "");
            }
            if (state.deleted != null) {
              context.pop();
              // getIt<AdminRoomsCubit>()
              //     .fetchRooms(workSpace != null ? workSpace.id : "");
            }
          },
          bloc: cubit,
          builder: (context, state) {
            log("buildedddd");
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //!!!
                          verticalSpace(20),
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                  )),
                              horizantalSpace(20),
                              Text(
                                "New ",
                                style: TextStyles.font22blackMeduim,
                              ),
                              Expanded(child: SizedBox()),
                              roomModel != null
                                  ? GestureDetector(
                                      onTap: () {
                                        cubit.deleteRoom(
                                            roomModel!.id!, context);
                                      },
                                      child: Container(
                                        width: 110.h,
                                        height: 40.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.red,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Delete",
                                            style: TextStyles.font20WhiteBold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          

                          TextFormFieldWithLabel(
                            label: "Title",
                            hintText: "Title",
                            focusNode: titleNode,
                            func: (value) {
                              cubit.titleChange(value);
                            },
                            controller: cubit.titleController,
                            hintStyle: TextStyles.font14GreyRegular,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Title can\'t be empty';
                              } else if (value.length <= 5) {
                                return 'Title must be greater than 5 characters';
                              }
                              return null;
                            },
                          ),
                          verticalSpace(10.h),

                          // Description Field
                          TextFormFieldWithLabel(
                            focusNode: decriptionNode,
                            controller: cubit.descriptionController,
                            label: "Description",
                            hintText: "Enter workspace description",
                            func: (value) {
                              cubit.descriptionChange(value);
                            },
                            hintStyle: TextStyles.font14GreyRegular,
                            minLines: 3,
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Description can\'t be empty';
                              } else if (value.split(' ').length <= 5) {
                                return 'Description must be greater than 50 words';
                              }
                              return null;
                            },
                          ),
                          //
                          verticalSpace(10.h),
                          // Image Picker
                          CustomImagePicker(
                            title: "Image",
                            onImageSelected: (image) {
                              if (image == null) {
                                log("nulllled");
                                cubit.selecteImageIsNullChange(true);
                              } else {
                                cubit.selecteImageIsNullChange(null);
                              }
                              cubit.imageChange(image);

                              decriptionNode.unfocus();
                              capacityNode.unfocus();
                              titleNode.unfocus();

                              pricePerHourFocusNode.unfocus();
                            },

                            // cubit.state.image == XFile("path")? null
                            //
                            //
                            selectedImage:
                                cubit.state.selectedImageIsNull != null
                                    ? null
                                    : cubit.state.image ?? roomModel?.imageLink,
                          ),

                          //
                          TextFormFieldWithLabel(
                            focusNode: capacityNode,
                            func: (value) {
                              cubit.capacityChange(value);
                            },
                            inputType: TextInputType.number,
                            textFormater: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: cubit.capacityController,
                            hintText: "Number of Seats",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "select you number of seates";
                              }
                              return null;
                            },
                            suffixIcon:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Text(
                                "Seat",
                                style: TextStyles.font14bluebold,
                              ),
                              horizantalSpace(10.w),
                              const Icon(
                                size: 25,
                                Icons.chair,
                                color: ColorsManager.mainBlue,
                              ),
                              horizantalSpace(20.w)
                            ]),
                          ),

                          //
                          TextFormFieldWithLabel(
                            controller: cubit.pricePerHourController,
                            focusNode: pricePerHourFocusNode,
                            func: (value) {
                              try {
                                cubit.pricePerHourChange(double.parse(value));
                              } on Exception {
                                CherryToast.error(
                                  title: Text("you have to Enter an number"),
                                ).show(context);
                              }
                            },
                            inputType: TextInputType.number,
                            textFormater: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            hintText: "Price Per Hour",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Select your price per hour";
                              }
                              return null;
                            },
                            suffixIcon:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Text(
                                "EGP",
                                style: TextStyles.font14bluebold,
                              ),
                              horizantalSpace(10.w),
                              const Icon(
                                size: 25,
                                Icons.more_time_sharp,
                                color: ColorsManager.mainBlue,
                              ),
                              horizantalSpace(20.w)
                            ]),
                          ),

                          verticalSpace(10.h),

                          // Start Date Picker
                          CustomDatePicker(
                            startingDate: DateTime.now(),
                            title: "Start Date",
                            onDatePicked: (value) {
                              decriptionNode.unfocus();
                              capacityNode.unfocus();
                              titleNode.unfocus();
                              pricePerHourFocusNode.unfocus();
                              log("value is ${value}");
                              temp = DateTime.parse(value ?? "");
                              cubit.tommorwChage(
                                  temp.add(const Duration(days: 1)));

                              cubit.startDateChange(value);
                            },
                          ),
                          verticalSpace(20.h),
                          // End Date Picker
                          CustomDatePicker(
                            startingDate: cubit.state.tommorw,
                            backgroundColor: ColorsManager.Inactive,
                            textStyle: TextStyles.font15PurbleRegular,
                            title: "End date",
                            onDatePicked: (value) {
                              decriptionNode.unfocus();
                              capacityNode.unfocus();
                              titleNode.unfocus();
                              pricePerHourFocusNode.unfocus();
                              cubit.endDateChange(value);
                              ;
                            },
                          ),
                          verticalSpace(15.h),
                          Row(
                            children: [
                              // Start Time Picker
                              CustomTimePicker(
                                title: "Start Time",
                                onTimePicked: (val) {
                                  decriptionNode.unfocus();
                                  capacityNode.unfocus();
                                  titleNode.unfocus();
                                  pricePerHourFocusNode.unfocus();
                                  log("Start Time: $val");
                                  cubit.startTimeChange(
                                      val); // Store the start time
                                },
                              ),
                              horizantalSpace(10),
                              CustomTimePicker(
                                backgroundColor: ColorsManager.Inactive,
                                title: "End Time",
                                textStyle: TextStyles.font15PurbleRegular,
                                onTimePicked: (val) {
                                  decriptionNode.unfocus();
                                  capacityNode.unfocus();
                                  titleNode.unfocus();
                                  pricePerHourFocusNode.unfocus();
                                  cubit.endTimeChange(val);
                                },
                              ),
                            ],
                          ),

                          verticalSpace(10),
                          //! validation
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: AppTextButton(
                              buttonText: "Done",
                              buttonStyle: TextStyles.font16WhiteBold,
                              onPress: () {
                                // Validate the form fields

                                if (_formKey.currentState!.validate()) {
                                  // Check if the start date is before the end date

                                  if (roomModel != null) {
                                    if (cubit.state.startDate != null ||
                                        cubit.state.endDate != null) {
                                      if (cubit.state.startDate == null ||
                                          cubit.state.endDate == null) {
                                        CherryToast.error(
                                          title: Text(
                                              'Please select both start and end dates'),
                                        ).show(context);
                                        return;
                                      }
                                    }
                                    // Validate start and end times
                                    if (cubit.state.startTime != null ||
                                        cubit.state.endTime != null) {
                                      // Ensure both start and end times are provided
                                      if (cubit.state.startTime == null ||
                                          cubit.state.endTime == null) {
                                        CherryToast.error(
                                          title: Text(
                                              'Please choose both start and end times'),
                                        ).show(context);
                                        return;
                                      }

                                      // Parse and validate time order
                                      DateTime startTime = DateTime.parse(
                                          "2012-02-27 ${cubit.state.startTime!}");
                                      DateTime endTime = DateTime.parse(
                                          "2012-02-27 ${cubit.state.endTime!}");

                                      if (startTime.isAfter(endTime)) {
                                        CherryToast.error(
                                          title: Text(
                                              'Start time must be earlier than end time'),
                                        ).show(context);
                                        return;
                                      }
                                    }
                                    cubit.editRoom(
                                        RoomModel(
                                            imageFile: cubit.state.image,
                                            title: cubit.state.title,
                                            description:
                                                cubit.state.description,
                                            capacity: cubit.state.capacity !=
                                                    null
                                                ? int.parse(
                                                    cubit.state.capacity ?? "")
                                                : null,
                                            startDate: cubit.state.startDate,
                                            endDate: cubit.state.endDate,
                                            startTime: cubit.state.startTime,
                                            endTime: cubit.state.endTime,
                                            pricePerHour:
                                                cubit.state.pricePerHour,
                                            id: roomModel.id),
                                        context);

                                    // Validate start and end dates
                                  } else {
                                    if (cubit.state.startDate == null) {
                                      return CherryToast.error(
                                              title: Text(
                                                  'Please select an end date'))
                                          .show(context);
                                    }
                                    if (cubit.state.endDate == null) {
                                      CherryToast.error(
                                              title: Text(
                                                  'Please select an end date'))
                                          .show(context);
                                      return;
                                    }

                                    if (cubit.state.startTime != null &&
                                        cubit.state.endTime != null) {
                                      DateTime startTime = DateTime.parse(
                                          "2012-02-27 ${cubit.state.startTime!}");
                                      DateTime endTime = DateTime.parse(
                                          "2012-02-27 ${cubit.state.endTime!}");

                                      if (startTime.isAfter(endTime)) {
                                        CherryToast.error(
                                                title: Text(
                                                    'please choose start Time less than end Time '))
                                            .show(context);
                                        return;
                                      }
                                    } else {
                                      CherryToast.error(
                                              title: Text(
                                                  'please choose start and end time '))
                                          .show(context);
                                    }
                                    log("${state.toMap()}");
                                    cubit.AddNewRoom(
                                        RoomModel.fromLocalMap(
                                            state.toMap(),
                                            workSpace != null
                                                ? workSpace.id
                                                : ""),
                                        context);
                                  }

                                  // If form is valid, image is selected, and date/time checks pass, proceed with submission

                                  // Add your data submission logic here
                                  // For example, calling cubit.submitRoomData()
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                state.isLoading == true
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: ColorsManager.mainBlack.withOpacity(.000001),
                      )
                    : SizedBox(),
                state.isLoading == true
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
                    : SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}
//  Align(
//                   alignment: Alignment.center,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: ColorsManager.lightGrey.withOpacity(.5),
//                         borderRadius: BorderRadius.circular(12)),
//                     width: 150.w,
//                     height: 150.w,
//                     child: const Center(child: CircularProgressIndicator()),
//                   ),
//                 )
//               ],
