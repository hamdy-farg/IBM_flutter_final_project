import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/helpers/string_extensions.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/signup_repo.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/sign_in_bloc/sign_in_cubit.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/sign_in_bloc/sign_in_state.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_button_authentication.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_text_widget.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_textfield.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/hyper_text.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/logo_widget.dart';

final _formKey = GlobalKey<FormState>();

class SingInScreen extends StatelessWidget {
  const SingInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<SignInCubit>();
    cubit.clearAll();
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30).h,
            child: BlocConsumer<SignInCubit, SignInState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state.user != null) {
                    String? role = CacheHelper.sharedPreferences
                        .getString(cacheHelperString.role);
                    if (role != null) {
                      if (role == "admin") {
                        context.pushReplacementNamed(Routes.workspaceStatus);
                      } else if (role == "client") {
                        context.pushReplacementNamed(Routes.editProfile);
                      }
                    }
                  }
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return Stack(
                    children: [
                      ListView(
                        children: [
                          verticalSpace(40),
                          const LogoWidget(),
                          verticalSpace(20),
                          CustemText(
                            text: 'Sign in',
                            textStyle: TextStyles.font20WhiteBold,
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
                          ),
                          verticalSpace(20),
                          CustemTextfield(
                            text: 'Password',
                            obscuredText: true,
                            func: (value) {
                              cubit.passwordChange(value);
                            },
                            icon: const Icon(Icons.lock),
                            Validator: (val) {
                              if (!val!.isValidPassword) {
                                return "Enter a valid Password";
                              }
                              return null;
                            },
                          ),
                          verticalSpace(10),
                          Container(
                            alignment: Alignment.centerRight,
                            child: HyperText(
                              text: 'Forgot Password?',
                              onPressed: () {
                                context.pushNamed('/resetPassword');
                              },
                            ),
                          ),
                          verticalSpace(20),
                          CustemButtonAuthentication(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.sigIn(cubit.state, context);
                              }
                            },
                          ),
                          verticalSpace(180),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustemText(
                                text: 'Don’t have an account?',
                                textStyle: TextStyles.font15BlackRegular,
                              ),
                              HyperText(
                                text: 'Sign Up',
                                textStyle: TextStyles.font15PurbleRegular,
                                onPressed: () {
                                  context.pushNamed(Routes.signUp);
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      state.isLoaind == true
                          ? Container(
                              width: double.infinity,
                              height: double.infinity,
                              color:
                                  ColorsManager.mainBlack.withOpacity(.000001),
                            )
                          : const SizedBox(),
                      state.isLoaind == true
                          ? Align(
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        ColorsManager.lightGrey.withOpacity(.5),
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
                }),
          ),
        ),
      ),
    );
  }
}
