import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatelessWidget {
  final String title;
  final Color borderColor;
  final Color iconColor;
  final double iconSize;
  final Function(XFile?) onImagePicked;
  final ImageSource imageSource;
  final XFile? selectedImage;

  const CustomImagePicker({
    super.key,
    required this.title,
    this.borderColor = ColorsManager.semiWhite,
    this.iconColor = ColorsManager.mainBlue,
    this.iconSize = 55,
    required this.onImagePicked,
    this.imageSource = ImageSource.gallery,
    this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    log("hi i'm image $selectedImage");
    return Column(
      children: [
        Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          width: 317.w,
          height: 170.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () async {
                // Trigger the image picker logic
                final XFile? image =
                    await ImagePicker().pickImage(source: imageSource);

                // Pass the picked image to the callback
                onImagePicked(image);
              },
              child: selectedImage == null
                  ? Icon(
                      size: iconSize,
                      Icons.add,
                      color: iconColor,
                    )
                  : Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(selectedImage!.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: IconButton(
                            onPressed: () {
                              // Reset the image by triggering the callback with null
                              onImagePicked(null);
                            },
                            icon: CircleAvatar(
                              radius: 15.sp,
                              backgroundColor: Colors.grey.shade300,
                              child: Icon(
                                Icons.remove,
                                color: iconColor,
                                size: 22.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
