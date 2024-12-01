import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
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
    cubit.clearAll();
    FocusNode titleNode = FocusNode();
    FocusNode capacityNode = FocusNode();
    FocusNode decriptionNode = FocusNode();
    DateTime temp = DateTime.now();
    DateTime tomorrow = temp.add(const Duration(days: 1)); // Add 1 day

    cubit.clearAll();

    return Scaffold(
      // appBar: AppBar(
      //   leading: GestureDetector(
      //       onTap: () {
      //         context.pushReplacementNamed(Routes.addNewWorkSpace);
      //       },
      //       child: const Icon(Icons.arrow_back)),
      //   backgroundColor: Colors.white,
      //   title: const Text("New Room"),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: BlocBuilder<AddNewRoomCubit, AddNewRoomState>(
              bloc: cubit,
              builder: (context, state) {
                log("Hi HI: HI ");
                return Form(
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
                        ],
                      ),
                      // Title Field
                      TextFormFieldWithLabel(
                        label: "Title",
                        hintText: "Title",
                        focusNode: titleNode,
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
                        focusNode: decriptionNode,
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
                        onImagePicked: (image) {
                          log("$image");
                          cubit.imageChange(image);
                          decriptionNode.unfocus();
                          capacityNode.unfocus();
                          titleNode.unfocus();
                        },
                        selectedImage: cubit.state.image,
                      ),
                      verticalSpace(5),
                      TextFormFieldWithLabel(
                        focusNode: capacityNode,
                        func: (value) {
                          cubit.capacityChange(value);
                        },
                        inputType: TextInputType.number,
                        textFormater: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        label: "Capacity",
                        hintText: "Number of Seats",
                        suffixIcon:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          const Text(" Seat"),
                          horizantalSpace(5.w),
                          const Icon(
                            Icons.chair,
                            color: ColorsManager.mainBlue,
                          ),
                          horizantalSpace(5.w)
                        ]),
                      ),

                      verticalSpace(10.h),

                      // Start Date Picker
                      CustomDatePicker(
                        startingDate: DateTime.now(),
                        title: "Start Date",
                        onDatePicked: (value) {
                          temp = DateTime.parse(value ?? "The value is null");
                          tomorrow = temp.add(const Duration(days: 1));
                          cubit.startDateChange(value ?? "Start date is null");
                        },
                      ),
                      verticalSpace(20.h),

                      // End Date Picker
                      CustomDatePicker(
                        startingDate: tomorrow,
                        backgroundColor: ColorsManager.Inactive,
                        textStyle: TextStyles.font15PurbleRegular,
                        title: "End date",
                        onDatePicked: (value) {
//!
cubit.endDateChange(value??"");
                        },
                      ),
                      verticalSpace(15.h),
                      Row(
                        children: [
                          // Start Time Picker
                          CustomTimePicker(
                            title: "Start Time",
                            onTimePicked: (val) {
                              log("Start Time: $val");
                              cubit.startTimeChange(val ??
                                  "Start Date is null"); // Store the start time
                            },
                          ),
                          horizantalSpace(10),
                          CustomTimePicker(
                            backgroundColor: ColorsManager.Inactive,
                            title: "End Time",
                            textStyle: TextStyles.font15PurbleRegular,
                            onTimePicked: (val) {
                              cubit.endTimeChange(val ?? "");
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
                                      content:
                                          Text('Please select an end date')),
                                );
                                return;
                              }

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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
