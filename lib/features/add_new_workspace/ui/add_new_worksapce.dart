import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/ui/widgets/image_picker.dart';
import '../../../../core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/widgets/app_text_button.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/ui/widgets/location_picker.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/ui/widgets/textfield_with_label.dart';

class AddNewWorkspace extends StatefulWidget {
  const AddNewWorkspace({super.key});

  @override
  _AddNewWorkspaceState createState() => _AddNewWorkspaceState();
}

class _AddNewWorkspaceState extends State<AddNewWorkspace> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers to capture the form values
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Variables to track if image and location are picked
  File? _pickedImage;
  bool _isImagePicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("New  "),
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
                    controller: _titleController,
                    label: "Title",
                    hintText: "Title",
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
                    controller: _descriptionController,
                    label: "Description",
                    hintText: "Enter workspace description",
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

                  // Image Picker Widget (Use the custom widget)
                  ImagePicker(
                    onImagePicked: (File? image) {
                      if (image == null) {
                        print("No image was selected.");
                      } else {
                        print("Image picked: ${image.path}");
                      }
                      setState(() {
                        _pickedImage = image;
                        _isImagePicked = image != null;
                      });
                    },
                  ),
                  verticalSpace(8.h),

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
                          if (!_isImagePicked) {
                            // If no image is picked, show a warning
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please pick an image')),
                            );
                            return;
                          }

                          // If form is valid and image is picked, submit data
                          String title = _titleController.text;
                          String description = _descriptionController.text;
                          print('Workspace created: $title, $description');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill out all fields correctly')),
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
