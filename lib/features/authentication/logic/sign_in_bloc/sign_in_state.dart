// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ibm_flutter_final_project/features/authentication/data/models/user_auth_model.dart';

class SignInState {
  String? email;
  String? password;
  bool? isLoaind;
  String? message;
  UserAuthModel? user;

  SignInState({
    this.email,
    this.password,
    this.isLoaind,
    this.message,
    this.user,
  });

  SignInState copyWith(
      {String? email,
      String? password,
      bool? isLoaind,
      String? message,
      UserAuthModel? user}) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoaind: isLoaind ?? this.isLoaind,
      message: message ?? this.message,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email_address': email,
      'password': password,
    };
  }
}
