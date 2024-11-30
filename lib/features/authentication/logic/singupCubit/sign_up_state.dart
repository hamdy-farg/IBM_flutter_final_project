// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ibm_flutter_final_project/features/authentication/data/models/user_auth_model.dart';

class SignUpState {
  String? fName;
  String? lName;
  String? email;
  String? password;
  String? confirmPassword;
  String? message;
  bool? isLoading;
  UserAuthModel? user;
  SignUpState(
      {this.fName,
      this.lName,
      this.email,
      this.password,
      this.confirmPassword,
      this.isLoading,
      this.message,
      this.user});

  SignUpState copyWith({
    String? fName,
    String? lName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    String? message,
    UserAuthModel? user,
  }) {
    return SignUpState(
      fName: fName ?? this.fName,
      lName: lName ?? this.lName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'f_name': fName,
      'l_name': lName,
      'email_address': email,
      'password': confirmPassword,
    };
  }
}
