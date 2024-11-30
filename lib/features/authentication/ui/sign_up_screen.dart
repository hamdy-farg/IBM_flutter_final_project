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

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

TextEditingController _password = TextEditingController();
TextEditingController _confirmpassword = TextEditingController();

class _SignUpScreenState extends State<SignUpScreen> {
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
                LogoWidget(),
                verticalSpace(20),
                CustemText(
                  text: 'Sign Up',
                  textStyle: TextStyles.font20WhiteBold,
                ),
                verticalSpace(20),
                CustemTextfield(
                  text: 'First name',
                  icon: Icon(Icons.person),
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
                  text: 'Last name',
                  icon: Icon(Icons.person),
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
                  icon: Icon(Icons.lock),
                  Validator: (val) {
                    if (!val!.isValidPassword) {
                      return "Enter a valid Password";
                    }
                    return null;
                  },
                  textEditingController: _password,
                ),
                verticalSpace(10),
                verticalSpace(20),
                CustemTextfield(
                  text: 'Confirm password',
                  obscuredText: true,
                  icon: Icon(Icons.lock),
                  textEditingController: _confirmpassword,
                  Validator: (val) {
                    if (!val!.isValidPassword &&
                        _password.text != _confirmpassword.text) {
                      return "It's not confirmend";
                    }
                    return null;
                  },
                ),
                verticalSpace(30),
                CustemButtonAuthentication(
                  text: 'Sign up',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
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
                        context.pushNamed('/loginScreen');
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
