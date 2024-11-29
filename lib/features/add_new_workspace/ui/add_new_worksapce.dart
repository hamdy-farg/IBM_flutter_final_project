import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/app_text_button.dart';
import 'package:ibm_flutter_final_project/core/widgets/image_picker.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit_state.dart';
 import 'package:ibm_flutter_final_project/features/add_new_workspace/ui/widgets/location_picker.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/ui/widgets/textfield_with_label.dart';

import '../../../../core/helpers/spacing.dart';

class AddNewWorkspace extends StatefulWidget {
  const AddNewWorkspace({super.key});

  @override
  _AddNewWorkspaceState createState() => _AddNewWorkspaceState();
}

class _AddNewWorkspaceState extends State<AddNewWorkspace> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variables to track if image and location are picked

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<AddNewWorkSpaceCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("New "),
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
                  verticalSpace(10.h),
                 BlocProvider(
  create: (_) => AddNewWorkSpaceCubit(),
  child: BlocBuilder<AddNewWorkSpaceCubit, AddNewWorkSpaceState>(
    builder: (context, state) {
          log("image is  in screen ${state.imageFile}");

      final cubit = context.read<AddNewWorkSpaceCubit>();
      return CustomImagePicker(
        title: "Image",
        onImagePicked: (image) {
          // Call the cubit's imageChange method with the picked image
          cubit.imageChange(image);
        },
        selectedImage: state.imageFile, // Use the current image from the cubit's state
      );
    },
  ),
),

                  // Location Picker Widget
                  LocationPickerWidget(onLocationPicked: (location) {
                    // Handle location picked
                  }),
                  verticalSpace(20.h),
              

                  // Create New Workspace Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: AppTextButton(
                      buttonText: "Create New Workspace",
                      buttonStyle: TextStyles.font16WhiteBold,
                      onPress: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          if (cubit.state.imageFile == null) {
                            // If no image is picked, show a warning
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please pick an image')),
                            );
                            return;
                          }

                          // If form is valid and image is picked, submit data
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please fill out all fields correctly')),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
