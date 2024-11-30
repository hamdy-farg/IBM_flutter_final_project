import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/features/User/logic/edit_profile/edit_profile_cubit.dart';
import 'package:ibm_flutter_final_project/features/User/logic/edit_profile/edit_profile_state.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/signup_repo.dart';
import 'package:image_picker/image_picker.dart';

class ImgePickerWidget extends StatelessWidget {
  final EditProfileState state;
  const ImgePickerWidget({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<EditProfileCubit>();

    final image =
        CacheHelper.sharedPreferences.getString(cacheHelperString.image);

    return MaterialButton(
      splashColor: Colors.transparent,
      onPressed: () async {
        final XFile? image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        cubit.imageChange(image);
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(26)),
            child: SizedBox(
              height: 132.h,
              width: 132.w,
              child: state.image != null
                  ? Image(
                      image: FileImage(File(state.image!.path)),
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      "${image ?? ""}?${DateTime.now().millisecondsSinceEpoch}" ??
                          "",
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            top: 80.sp,
            left: 80.sp,
            child: Container(
              width: 47.w,
              height: 47.h,
              decoration: const BoxDecoration(
                  color: ColorsManager.userGrey2,
                  borderRadius: BorderRadius.all(Radius.circular(11))),
              child: Image.asset('assets/images/photo-camera.png'),
            ),
          ),
        ],
      ),
    );
  }
}
