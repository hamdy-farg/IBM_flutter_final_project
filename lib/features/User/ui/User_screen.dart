import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/User/ui/widgets/custem_container_widget.dart';
import 'package:ibm_flutter_final_project/features/User/ui/widgets/edit_profile_widger.dart';
import 'package:ibm_flutter_final_project/features/User/ui/widgets/icon_button_widget.dart';
import 'package:ibm_flutter_final_project/features/User/ui/widgets/user_image.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Expanded(
              child: Container(
            color: ColorsManager.userGrey,
          )),
          ListView(
            children: [
              verticalSpace(10),
              Row(
                children: [],
              ),
              verticalSpace(20),
              Column(
                children: [
                  UserImage(),
                  verticalSpace(20),
                  CustemText(
                    text: 'David Silbia',
                    textStyle: TextStyles.font24BlackSemiBold,
                  ),
                  verticalSpace(10),
                  CustemText(
                    text: '@David Silbia',
                    textStyle: TextStyles.font14GreyRegular,
                  ),
                  verticalSpace(10),
                  EditProfileWidger(),
                  verticalSpace(20),
                  CustemContainerWidget()
                ],
              )
            ],
          ),
        ],
      )),
    );
  }
}
