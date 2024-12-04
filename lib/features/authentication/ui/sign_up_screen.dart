import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/helpers/string_extensions.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/singupCubit/sign_up_cubit.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/singupCubit/sign_up_state.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_button_authentication.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_text_widget.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_textfield.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/hyper_text.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/logo_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final cubit = getIt<SignUpCubit>();
    cubit.clearState();
    return Form(
      key: formKey,
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<SignUpCubit, SignUpState>(
            bloc: cubit,
            listener: (context, state) {
              if (state.user != null) {
                context.pushReplacementNamed(Routes.loginScreen);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30).h,
                    child: ListView(
                      children: [
                        verticalSpace(40),
                        const LogoWidget(),
                        verticalSpace(20),
                        CustemText(
                          text: 'Sign Up',
                          textStyle: TextStyles.font20WhiteBold,
                        ),
                        verticalSpace(20),
                        CustemTextfield(
                          func: (value) => cubit.fNameChange(value),
                          text: 'First name',
                          icon: const Icon(Icons.person),
                          textInputType: TextInputType.name,
                          Validator: (val) {
                            if (!val!.isValidName) {
                              return "Enter a valid name";
                            }
                            return null;
                          },
                        ),
                        verticalSpace(20),
                        CustemTextfield(
                          func: (value) => cubit.lNameChange(value),
                          text: 'Last name',
                          icon: const Icon(Icons.person),
                          textInputType: TextInputType.name,
                          Validator: (val) {
                            if (!val!.isValidName) {
                              return "Enter a valid name";
                            }
                            return null;
                          },
                        ),
                        verticalSpace(20),
                        CustemTextfield(
                          func: (value) => cubit.emailChange(value),
                          Validator: (val) {
                            if (!val!.isValidEmail) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                        verticalSpace(20),
                        CustemTextfield(
                          func: (value) => cubit.password(value),
                          text: 'Password',
                          obscuredText: true,
                          icon: const Icon(Icons.lock),
                          Validator: (val) {
                            if (!val!.isValidPassword) {
                              return "Enter a valid Password";
                            }
                            return null;
                          },
                          // textEditingController: _password,
                        ),
                        verticalSpace(10),
                        verticalSpace(20),
                        CustemTextfield(
                          func: (value) => cubit.confirmPassword(value),
                          text: 'Confirm password',
                          obscuredText: true,
                          icon: const Icon(Icons.lock),
                          // textEditingController: _confirmpassword,
                          Validator: (val) {
                            if (!val!.isValidPassword &&
                                cubit.password != cubit.confirmPassword) {
                              return "It's not confirmend";
                            }
                            return null;
                          },
                        ),
                        verticalSpace(30),
                        CustemButtonAuthentication(
                            text: 'Sign up',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                log("${cubit.state.lName}");
                                cubit.signUp(cubit.state, context);
                              }
                            }),
                        verticalSpace(40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustemText(
                              text: 'Already have an account?',
                              textStyle: TextStyles.font15BlackRegular,
                            ),
                            HyperText(
                              text: 'Sign In',
                              textStyle: TextStyles.font15PurbleRegular,
                              onPressed: () {
                                context
                                    .pushReplacementNamed(Routes.loginScreen);
                              },
                            )
                          ],
                        ),
                      ],
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
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ),
                        )
                      : const SizedBox(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
