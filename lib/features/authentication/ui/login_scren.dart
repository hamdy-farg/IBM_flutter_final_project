import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/helpers/string_extensions.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_button_authentication.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_text_widget.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_textfield.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/hyper_text.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/logo_widget.dart';

final _formKey = GlobalKey<FormState>();

class LoginScren extends StatefulWidget {
  const LoginScren({super.key});

  @override
  State<LoginScren> createState() => _LoginScrenState();
}

class _LoginScrenState extends State<LoginScren> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30).h,
            child: ListView(
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
                    if (_formKey.currentState!.validate()) {}
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
                        context.pushNamed('/signUp');
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
