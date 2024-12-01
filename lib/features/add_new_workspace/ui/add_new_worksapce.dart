import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/app_text_button.dart';
import 'package:ibm_flutter_final_project/core/widgets/image_picker.dart';
import 'package:ibm_flutter_final_project/core/widgets/location_picker.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit_state.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/ui/widgets/textfield_with_label.dart';
import '../../../../core/helpers/spacing.dart';

class AddNewWorkspace extends StatelessWidget {
  AddNewWorkspace({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = getIt<AddNewWorkSpaceCubit>();
    cubit.clearAll();
    FocusNode titleNode = FocusNode();
  
    FocusNode decriptionNode = FocusNode();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: BlocBuilder<AddNewWorkSpaceCubit, AddNewWorkSpaceState>(
            bloc: cubit,
            builder: (context, state) {
              log("iamge change");
              return Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocListener<AddNewWorkSpaceCubit,
                              AddNewWorkSpaceState>(
                            bloc: cubit,
                            listener: (context, state) {
                              log("${state.workSpace}");
                              if (state.workSpace != null) {
                                context.pushReplacementNamed(
                                    Routes.workspaceStatus);
                              }
                              return;
                            },
                            child: const SizedBox(),
                          ),

//!!!!!!!
                          verticalSpace(10),
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

                          CustomImagePicker(
                            title: "Image",
                            onImagePicked: (image) {
                              // Call the cubit's imageChange method with the picked image
                              log("$image");
                              cubit.imageChange(image);

                              //
                              decriptionNode.unfocus();
                              //
                              titleNode.unfocus();
                            },
                            selectedImage: cubit.state.imageFile,
                            // Use the current image from the cubit's state
                          ),

                          verticalSpace(10),
                          // Location Picker Widget
                          // LocationPickerWidget(onLocationPicked: (location) {
                          // // Handle location picked
                          // }),

                          LocationPickerWidget(
                            onLocationPicked: (pickedLocation) {
                              final googleMapUrl =
                                  'https://www.google.com/maps?q=${pickedLocation.latitude},${pickedLocation.longitude}';
                              log(googleMapUrl);

                              cubit.locationChange(
                                  googleMapUrl); // Use cubit to save the location

                              decriptionNode.unfocus();
                              titleNode.unfocus();
                            },
                          ),

                          verticalSpace(20.h),

                          // Create New Workspace Button
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: AppTextButton(
                              buttonText: "Create New Workspace",
                              buttonStyle: TextStyles.font16WhiteBold,
                              onPress: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  if (cubit.state.imageFile == null) {
                                    // If no image is picked, show a warning
                                    CherryToast.error(
                                      toastPosition: Position.top,
                                      title: const Text('Please pick an image'),
                                    ).show(context);

                                    return;
                                  }
                                  if (cubit.state.locaiton == null) {
                                    // If no image is picked, show a warning
                                    CherryToast.error(
                                      toastPosition: Position.top,
                                      title:
                                          const Text('Please pick an location'),
                                    ).show(context);

                                    return;
                                  }
                                  cubit.addNewWorkSpace(cubit.state, context);
                                  // If form is valid and image is picked, submit data
                                }
                              },
                            ),
                          ),
                          verticalSpace(20)
                        ],
                      ),
                    ),
                  ),
                  state.isLoading == true
                      ? Align(
                          alignment: Alignment.center,
                          child: Center(
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
                          ),
                        )
                      : const SizedBox(),
                  state.isLoading == true
                      ? Expanded(
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: ColorsManager.mainBlack.withOpacity(.000001),
                          ),
                        )
                      : const SizedBox(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
