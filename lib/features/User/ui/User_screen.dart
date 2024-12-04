import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/image_network_widget.dart';
import 'package:ibm_flutter_final_project/features/User/logic/edit_profile/edit_profile_cubit.dart';
import 'package:ibm_flutter_final_project/features/User/logic/edit_profile/edit_profile_state.dart';
import 'package:ibm_flutter_final_project/features/User/ui/widgets/custem_container_widget.dart';
import 'package:ibm_flutter_final_project/features/User/ui/widgets/edit_profile_widger.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/sign_in_repo.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_text_widget.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? image =
        CacheHelper.sharedPreferences.getString(cacheHelperString.image);
    final cubit = getIt<EditProfileCubit>();

    return SafeArea(
        child: Stack(
      children: [
        Expanded(
            child: Container(
          color: ColorsManager.userGrey,
        )),
        ListView(
          children: [
            verticalSpace(10),
            const Row(
              children: [],
            ),
            verticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    logout(context);
                    context.pushReplacementNamed(Routes.loginScreen);
                  },
                  child: const Text(
                    "  logout",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<EditProfileCubit, EditProfileState>(
              bloc: cubit,
              builder: (context, state) {
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(26)),
                      child: SizedBox(
                          height: 132.h,
                          width: 132.w,
                          child: ImageNetworkWidget(
                              imageLink: image!, hight: 132.h, width: 132.w)),
                    ),
                    verticalSpace(20),
                    CustemText(
                      text: CacheHelper.sharedPreferences
                          .getString(cacheHelperString.fName),
                      textStyle: TextStyles.font24BlackSemiBold,
                    ),
                    verticalSpace(10),
                    CustemText(
                      text: CacheHelper.sharedPreferences
                          .getString(cacheHelperString.email),
                      textStyle: TextStyles.font14GreyRegular,
                    ),
                    verticalSpace(10),
                    const EditProfileWidger(),
                    verticalSpace(20),
                    const CustemContainerWidget()
                  ],
                );
              },
            )
          ],
        ),
      ],
    ));
  }
}
