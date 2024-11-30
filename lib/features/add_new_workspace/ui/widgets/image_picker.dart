import 'dart:developer';
import 'dart:io'; // Required to use File

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit_state.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<AddNewWorkSpaceCubit>();
    return BlocProvider(
      create: (_) => AddNewWorkSpaceCubit(),
      child: BlocBuilder<AddNewWorkSpaceCubit, AddNewWorkSpaceState>(
        bloc: cubit,
        builder: (context, state) {

          log("image is  in screen ${state.imageFile}");
          
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
                      final XFile? image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      cubit.imageChange(image);
                    },
                    child: state.imageFile == null
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
                                  File(state.imageFile!.path),
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
                                    cubit.imageChange(null);
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
