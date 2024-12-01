import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/app_text_button.dart';
import 'package:ibm_flutter_final_project/core/widgets/date_picker.dart';
import 'package:ibm_flutter_final_project/core/widgets/image_picker.dart';
import 'package:ibm_flutter_final_project/core/widgets/time_picker.dart';
import 'package:ibm_flutter_final_project/features/add-new-room/logic/cubit/add_new_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/add-new-room/logic/cubit/add_new_room_state.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/ui/widgets/textfield_with_label.dart';

class AddNewRoom extends StatelessWidget {
  AddNewRoom({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController capacityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<AddNewRoomCubit>();

    DateTime temp = DateTime.now();
    DateTime tomorrow = temp.add(const Duration(days: 1)); // Add 1 day

    cubit.clearAll();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              context.pushReplacementNamed(Routes.addNewWorkSpace);
            },
            child: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
        title: const Text("New Room"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Field
                  TextFormFieldWithLabel(
                    label: "Title",
                    hintText: "Title",
                    func: (value) {
                      cubit.titleChange(value);
                    },
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
                    label: "Description",
                    hintText: "Enter Room description",
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

                  BlocBuilder<AddNewRoomCubit, AddNewRoomState>(
                    bloc: cubit,
                    builder: (context, state) {
                      log("image is in screen ${state.image}");

                      return CustomImagePicker(
                        title: "Image",
                        onImagePicked: (image) {
                          cubit.imageChange(image);
                        },
                        selectedImage: state.image,
                      );
                    },
                  ),
                  TextFormFieldWithLabel(
                    func: (value) {
                      cubit.capacityChange(value);
                    },
                    inputType: TextInputType.number,
                    textFormater: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    label: "Capacity",
                    hintText: "Number of Seats",
                    suffixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
                      const Text(" Seat"),
                      horizantalSpace(5.w),
                      const Icon(
                        Icons.chair,
                        color: ColorsManager.mainBlue,
                      ),
                      horizantalSpace(5.w)
                    ]),
                  ),

                  verticalSpace(20.h),

                  // Start Date Picker
                  CustomDatePicker(
                    startingDate: DateTime.now(),
                    title: "Start Date",
                    onDatePicked: (value) {
                      temp = DateTime.parse(value ?? "The value is null");
                      tomorrow = temp.add(const Duration(days: 1));
                      cubit.startDateChange(value!);
                    },
                  ),
                  verticalSpace(20.h),

                  // End Date Picker
                  BlocBuilder<AddNewRoomCubit, AddNewRoomState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return CustomDatePicker(
                          startingDate: tomorrow,
                          backgroundColor: ColorsManager.Inactive,
                          textStyle: TextStyles.font15PurbleRegular,
                          title: "End date",
                          onDatePicked: (value) {
                            cubit.endDateChange(value!);
                          });
                    },
                  ),
                  verticalSpace(20.h),
                  Row(
                    children: [
                      // Start Time Picker
                      CustomTimePicker(
                        title: "Start Time",
                        onTimePicked: (val) {
                          log("Start Time: $val");
                          cubit.startTimeChange(
                              val ?? ""); // Store the start time
                        },
                      ),
                      horizantalSpace(10),
                      BlocBuilder<AddNewRoomCubit, AddNewRoomState>(
                        bloc: cubit,
                        builder: (context, state) {
                          return CustomTimePicker(
                            backgroundColor: ColorsManager.Inactive,
                            title: "End Time",
                            textStyle: TextStyles.font15PurbleRegular,
                            onTimePicked: (val) {
                              cubit.endTimeChange(val ?? "");
                            },
                          );
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
                          if (cubit.state.endDate == null ||
                              cubit.state.endDate!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please select an end date')),
                            );
                            return;
                          }

                          DateTime endDateTime =
                              DateTime.parse(cubit.state.endDate!);

                          if (temp.isAfter(endDateTime)) {
                            // If the start date is after the end date, show a SnackBar warning
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Start date cannot be after End date')),
                            );
                            return; // Stop further execution
                          }
                          log("start time is  ${cubit.state.startTime}");
                          log("end time is  ${cubit.state.endTime}");
                          // You should also check if the end time is after the start time here (if needed).
                          // For example:
                          if (cubit.state.startTime != null &&
                              cubit.state.endTime != null) {
                            DateTime startTime =
                                DateTime.parse(cubit.state.startTime!);
                            DateTime endTime =
                                DateTime.parse(cubit.state.endTime!);
                            log('--------------------------------------------------------------');
                            log("start time is  $startTime");
                            log("start time is  $endTime");
                            if (endTime.isBefore(startTime)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'End time cannot be before Start time')),
                              );
                              return;
                            }
                          }

                          // If form is valid, image is selected, and date/time checks pass, proceed with submission
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Room added successfully')),
                          );

                          // Add your data submission logic here
                          // For example, calling cubit.submitRoomData()
                        } else {
                          // If the form is not valid, show an error SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please fill out all fields correctly')),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
