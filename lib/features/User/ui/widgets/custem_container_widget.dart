import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/features/User/logic/verify_user/verify_user_cubit.dart';
import 'package:ibm_flutter_final_project/features/User/ui/widgets/custem_user_row.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/sign_in_repo.dart';

class CustemContainerWidget extends StatelessWidget {
  const CustemContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 375.w,
        height: 420.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
          color: ColorsManager.mainWhite,
          border: Border.all(
            color: ColorsManager.mainGrey,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20.w, vertical: 16.h), // Adjust padding
          child: BlocConsumer<VerifyUserCubit, VerifyUserState>(
              bloc: getIt<VerifyUserCubit>(),
              listener: (context, state) async {
                log("$state");
                if (state is VerifyUserFial) {
                  CherryToast.error(
                    title: Text(state.message),
                  ).show(context);
                } else if (state is VerifyUserSuccess) {
                  CacheHelper.sharedPreferences
                              .getString(cacheHelperString.is_confirmed) ==
                          "False"
                      ? CherryToast.success(
                          title: Text(
                              "the email was sent check your email account"),
                        ).show(context)
                      : CherryToast.success(
                          title: Text("your email is verified successfully"),
                        ).show(context);
                }
              },
              builder: (context, state) {
                log("rebuild");
                return Column(
                  children: [
                    CustemUserRow(),

                    // Default row
                    SizedBox(height: 25.h), // Vertical space
                    const CustemUserRow(
                      text: 'Settings',
                      image: 'assets/images/settings.png',
                    ),
                    SizedBox(height: 25.h),
                    const CustemUserRow(
                      text: 'Change password',
                      image: 'assets/images/loack.png',
                    ),
                    SizedBox(height: 25.h),
                    const CustemUserRow(
                      text: 'About',
                      image: 'assets/images/about.png',
                    ),
                  ],
                );
              }),
        ));
  }
}
