import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/widgets/image_network_widget.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatelessWidget {
  final String title;
  final Color borderColor;
  final Color iconColor;
  final double iconSize;
  final Function(XFile?) onImageSelected; // Renamed for clarity
  final ImageSource imageSource;
  final Object? selectedImage;

  const CustomImagePicker({
    super.key,
    required this.title,
    this.borderColor = ColorsManager.semiWhite,
    this.iconColor = ColorsManager.mainBlue,
    this.iconSize = 55,
    required this.onImageSelected,
    this.imageSource = ImageSource.gallery,
    this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
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
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () async {
                final XFile? image = await ImagePicker()
                    .pickImage(source: imageSource, imageQuality: 100);
                onImageSelected(image);
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
                          child: selectedImage is XFile
                              ? Image.file(
                                  File((selectedImage as XFile).path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : ImageNetworkWidget(
                                  imageLink: selectedImage as String,
                                  width: 100,
                                  hight: 100,
                                ),
                        ),
                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: IconButton(
                            onPressed: () {
                              // Reset the image
                              onImageSelected(null);
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
