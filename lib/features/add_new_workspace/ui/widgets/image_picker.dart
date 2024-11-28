import 'dart:io'; // Required to use File

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit_state.dart';

class ImagePicker extends StatelessWidget {
  final Function(File?) onImagePicked;

  const ImagePicker({super.key, required this.onImagePicked});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddNewWorkSpaceCubit(),
      child: BlocBuilder<AddNewWorkSpaceCubit, AddNewWorkSpaceState>(
        builder: (context, image) {
          return Column(
            children: [
              const Center(
                child: Text(
                  "Image",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 5.h),
              Container(
                width: 317.w,
                height: 170.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      // Trigger the image picker logic in the cubit
                      await context.read<AddNewWorkSpaceCubit>().pickImage();
                    },
                    child: image == null
                        ? const Icon(
                            size: 55,
                            Icons.add,
                            color: Colors.blue,
                          )
                        : Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  image,
                                  fit: BoxFit.cover,
                                  width: double.infinity.w,
                                  height: double.infinity.h,
                                ),
                              ),
                              Positioned(
                                top: 8.h,
                                right: 8.w,
                                child: IconButton(
                                  onPressed: () {
                                    // Reset image when the icon is pressed
                                    context
                                        .read<ImagePickerCubit>()
                                        .resetImage();
                                    onImagePicked(
                                        null); // Reset the image in the parent
                                  },
                                  icon: CircleAvatar(
                                    radius: 15.sp,
                                    backgroundColor: Colors.grey.shade300,
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.blue,
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
        },
      ),
    );
  }
}
