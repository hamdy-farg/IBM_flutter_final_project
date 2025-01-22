import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/User/data/repos/edit_profile_repo.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/sign_in_repo.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_button_authentication.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_text_widget.dart';

class CustemUserRow extends StatelessWidget {
  final String? text;
  final String? image;
  final VoidCallback? onPressed;

  const CustemUserRow({super.key, this.text, this.image, this.onPressed});

  @override
  Widget build(BuildContext context) {
    String? is_confirmed =
        CacheHelper.sharedPreferences.getString(cacheHelperString.is_confirmed);
    return InkWell(
      splashColor: Colors.amber,
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Aligns vertically
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: is_confirmed == "True" && text == null
                  ? ColorsManager.mainBlue
                  : ColorsManager.userGrey2,
            ),
            child: SizedBox(
              height: 24.h,
              width: 24.w,
              child: Image.asset(image ?? 'assets/images/authinticatin.png'),
            ),
          ),
          Spacer(),

          is_confirmed == "True" && text == null
              ? Expanded(
                  child: CustemText(
                    text: text ?? 'your email is verified',
                    textStyle: TextStyles.font24Black5Meduim,
                  ),
                )
              : InkWell(
                  onTap: () async {
                    is_confirmed = await CacheHelper.sharedPreferences
                        .getString(cacheHelperString.is_confirmed);
                    log("is confirmed ${is_confirmed}");
                    if (is_confirmed == "False" && text == null) {
                      await EditProfileRepo(dio: getIt<DioConsumer>())
                          .verifyUser();
                    }
                  },
                  child: text == null
                      ? CustemButtonAuthentication(
                          text: 'Tap To verify',
                          textStyle: TextStyles.font14WhiteBold,
                          width: 140,
                          height: 60,
                        )
                      : CustemText(
                          text: text ?? 'Tap To verify',
                          textStyle: TextStyles.fonst18BlackBold,
                        ),
                ),
          Spacer(),

          text == null
              ? SizedBox()
              : Icon(Icons.arrow_forward_ios_rounded,
                  size: 16.h), // Right-aligned icon
        ],
      ),
    );
  }
}
