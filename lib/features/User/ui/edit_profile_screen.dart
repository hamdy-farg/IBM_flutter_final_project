import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/helpers/string_extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/User/logic/edit_profile/edit_profile_cubit.dart';
import 'package:ibm_flutter_final_project/features/User/logic/edit_profile/edit_profile_state.dart';
import 'package:ibm_flutter_final_project/features/User/ui/widgets/imge_picker_widget.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_button_authentication.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_text_widget.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<EditProfileCubit>();
    cubit.clearAll();
    final GlobalKey<FormState> formKey = GlobalKey();
    cubit.fetchCachedData();
    return Scaffold(
      body: SafeArea(
          child: BlocBuilder<EditProfileCubit, EditProfileState>(
        buildWhen: (previous, current) {
          // Only rebuild if a specific property changes

          return previous.image != current.image ||
              previous.isLoading != current.isLoading;
        },
        bloc: cubit,
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                            child: const Icon(Icons.arrow_back),
                            onTap: () {
                              logout(context);
                            }),
                      ),
                      Center(
                        child: CustemText(
                          text: 'Edit profile',
                          textStyle: TextStyles.font24BlackBold,
                        ),
                      ),
                      verticalSpace(20),
                      ImgePickerWidget(
                        state: state,
                      ),
                      verticalSpace(40),
                      CustemTextfield(
                        func: (value) {
                          cubit.fNameChange(value);
                        },
                        textEditingController: cubit.fNameController,
                        Validator: (value) {
                          if (value!.length <= 3) {
                            return "first name must be more than 3 charcter";
                          }
                          return null;
                        },
                        text: 'First name',
                        icon: const Icon(Icons.person),
                      ),
                      verticalSpace(20),
                      CustemTextfield(
                        func: (value) {
                          cubit.lNameChange(value);
                        },
                        textEditingController: cubit.lNameController,
                        Validator: (value) {
                          if (value!.length <= 3) {
                            return "last name must be more than 3 charcter";
                          }

                          return null;
                        },
                        text: 'Last name',
                        icon: const Icon(Icons.person),
                      ),
                      verticalSpace(20),
                      CustemTextfield(
                        func: (value) {
                          cubit.emailChange(value);
                        },
                        Validator: (val) {
                          if (!val!.isValidEmail) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                        textEditingController: cubit.emailController,
                      ),
                      verticalSpace(20),
                      CustemTextfield(
                          func: (value) {
                            cubit.phoneChange(value);
                          },
                          textEditingController: cubit.phoneController,
                          Validator: (value) {
                            String egyptianPhonePattern = r'^01[0125][0-9]{8}$';
                            RegExp regExp = RegExp(egyptianPhonePattern);

                            if (!regExp.hasMatch(value ?? "")) {
                              return ("Enter valid Egyptian phone number");
                            }
                            return null;
                          },
                          text: 'Your phone number',
                          icon: const Icon(Icons.phone)),
                      verticalSpace(30),
                      CustemButtonAuthentication(
                        text: 'Upadte',
                        onPressed: () async {
                          if (state.isLoading == true) {
                          } else {
                            if (formKey.currentState!.validate()) {
                              cubit.fetchApiData(cubit.state, context);
                            }
                          }

                          // context.pushNamed(Routes.userScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              state.isLoading == true
                  ? Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: ColorsManager.mainBlack.withOpacity(.000001),
                    )
                  : const SizedBox(),
              state.isLoading == true
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorsManager.lightGrey.withOpacity(.5),
                            borderRadius: BorderRadius.circular(12)),
                        width: 150.w,
                        height: 150.w,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        },
      )),
    );
  }
}
