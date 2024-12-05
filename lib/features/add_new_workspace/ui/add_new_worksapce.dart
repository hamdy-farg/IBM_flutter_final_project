import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/app_text_button.dart';
import 'package:ibm_flutter_final_project/core/widgets/image_picker.dart';
import 'package:ibm_flutter_final_project/core/widgets/location_picker.dart';
import 'package:ibm_flutter_final_project/core/widgets/map_luncher_button.dart';
import 'package:ibm_flutter_final_project/core/widgets/textfield_with_label.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/workSpaceCubit/work_space_cubit.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/workSpaceCubit/work_space_state.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';

import '../../../../core/helpers/spacing.dart';

class AddNewWorkspace extends StatelessWidget {
  AddNewWorkspace({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = getIt<WorkSpaceCubit>();
    final workspace =
        ModalRoute.of(context)?.settings.arguments as WorkSpaceModel?;
    if (workspace != null) {
      cubit.isEdit(workspace, context);
    }
    FocusNode titleNode = FocusNode();
    FocusNode decriptionNode = FocusNode();
    log("Image link is start ${cubit.state.imageLink}");
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocListener<WorkSpaceCubit, WorkSpaceState>(
                          listenWhen: (prev, current) =>
                              current.workSpace != null,
                          bloc: cubit,
                          listener: (context, state) {
                            log("Image link is  in 1bloc ${cubit.state.imageLink}");
                            if (state.workSpace != null) {
                              context
                                  .pushReplacementNamed(Routes.workspaceStatus);
                              cubit.clearAll();
                            }
                            return;
                          },
                          child: const SizedBox(),
                        ),
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
                            const Expanded(
                              child: SizedBox(),
                            ),
                            workspace != null
                                ? GestureDetector(
                                    onTap: () {
                                      cubit.deleteNewWorkSpace(
                                          context, workspace.id);
                                    },
                                    child: Container(
                                      width: 110.h,
                                      height: 40.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
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

                        // Title Field
                        TextFormFieldWithLabel(
                          label: "Title",
                          hintText: "Title",
                          controller: cubit.titleController,
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
                          controller: cubit.descriptionController,
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

                        BlocBuilder<WorkSpaceCubit, WorkSpaceState>(
                          buildWhen: (previous, current) =>
                              previous.imageFile == current.imageFile ||
                              previous.imageLink == current.imageLink ||
                              current.imageLink == null ||
                              previous.imageFile == null,
                          bloc: cubit,
                          builder: (context, state) {
                            log("Image link is bloc2 ${cubit.state.imageLink}");

                            return CustomImagePicker(
                              title: "Image",
                              onImageSelected: (image) {
                                // Call the cubit's imageChange method with the picked image
                                log("$image");
                                cubit.state.imageLink = null;
                                cubit.imageChange(image);

                                //
                                decriptionNode.unfocus();
                                //
                                titleNode.unfocus();
                              },
                              selectedImage: cubit.state.imageFile ??
                                  cubit.state.imageLink,
                              // Use the current image from the cubit's state
                            );
                          },
                        ),

                        verticalSpace(10),
                        // Location Picker Widget
                        // LocationPickerWidget(onLocationPicked: (location) {
                        // // Handle location picked
                        // }),

                        LocationPickerWidget(
                          locationLatLong: workspace != null
                              ? extractLatLong(workspace.location)
                              : null,
                          onLocationPicked: (pickedLocation) {
                            final googleMapUrl =
                                'https://www.google.com/maps?q=${pickedLocation.latitude},${pickedLocation.longitude}';

                            cubit.locationChange(
                                googleMapUrl); // Use cubit to save the location

                            decriptionNode.unfocus();
                            titleNode.unfocus();
                          },
                        ),
                        verticalSpace(10.h),

                        BlocBuilder<WorkSpaceCubit, WorkSpaceState>(
                            bloc: cubit,
                            builder: (context, state) {
                              return state.locaiton != null
                                  ? urlButtonLuncher(url: state.locaiton ?? "")
                                  : SizedBox();
                            }),

                        verticalSpace(10.h),

                        // Create New Workspace Button
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: AppTextButton(
                            buttonText: "Create New Workspace",
                            buttonStyle: TextStyles.font16WhiteBold,
                            onPress: () async {
                              log("Image link is end ${cubit.state.imageLink}");

                              if (_formKey.currentState!.validate()) {
                                if (cubit.state.imageLink == null) {
                                  if (cubit.state.imageFile == null) {
                                    // If no image is picked, show a warning
                                    CherryToast.error(
                                      toastPosition: Position.top,
                                      title: const Text('Please pick an image'),
                                    ).show(context);

                                    return;
                                  }
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

                                if (workspace != null) {
                                  await cubit.editNewWorkSpace(
                                      cubit.state, context, workspace.id);
                                } else {
                                  await cubit.addNewWorkSpace(
                                      cubit.state, context);
                                }
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
                BlocBuilder<WorkSpaceCubit, WorkSpaceState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return state.isLoading == true
                          ? Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: ColorsManager.lightGrey
                                              .withOpacity(.5),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      width: 150.w,
                                      height: 150.w,
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    color: ColorsManager.mainBlack
                                        .withOpacity(.000001),
                                  ),
                                )
                              ],
                            )
                          : const SizedBox();
                    })
              ],
            )),
      ),
    );
  }
}
