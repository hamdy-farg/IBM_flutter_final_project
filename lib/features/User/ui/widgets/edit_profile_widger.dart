import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_text_widget.dart';

class EditProfileWidger extends StatelessWidget {
  const EditProfileWidger({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.transparent,
      onPressed: () {
        context.pushNamed(Routes.editProfile);
      },
      child: Container(
        height: 30.h,
        width: 126.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: ColorsManager.mainGrey),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: CustemText(
          text: 'Edit profile',
          textStyle: TextStyles.font15BlackRegular,
        ),
      ),
    );
  }
}
