import 'package:bloc/bloc.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/networks/api_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/models/user_auth_model.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/signup_repo.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/singupCubit/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  ApiConsumer dio;
  SignUpCubit(this.dio) : super(SignUpState());

  void fNameChange(String fName) {
    emit(state.copyWith(fName: fName));
  }

  void lNameChange(String lName) {
    emit(state.copyWith(lName: lName));
  }

  void emailChange(String email) {
    emit(state.copyWith(email: email));
  }

  void password(String password) {
    emit(state.copyWith(password: password));
  }

  void confirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void signUp(SignUpState user, context) async {
    emit(state.copyWith(isLoading: true));
    try {
      UserAuthModel userResponce = await SignupRepo(dio).singUp(user);
      emit(state.copyWith(user: userResponce));
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
    } on ServerException catch (e) {
      state.isLoading = null;
      emit(state.copyWith(isLoading: null));
      CherryToast.error(
        toastDuration: const Duration(seconds: 3),
        animationDuration: const Duration(seconds: 1),
        title: Text(
          e.errorModel.message,
          style: const TextStyle(color: Colors.red),
        ),
      ).show(context);
    }
  }

  void clearState() {
    state.fName = null;
    state.lName = null;
    state.email = null;
    state.confirmPassword = null;
    state.password = null;
    state.user = null;
    state.isLoading = null;
    state.message = null;
    emit(state.copyWith(message: null));

    emit(state.copyWith(fName: null));
    emit(state.copyWith(lName: null));
    emit(state.copyWith(email: null));
    emit(state.copyWith(confirmPassword: null));
    emit(state.copyWith(user: null));
    emit(state.copyWith(isLoading: null));

    emit(state.copyWith(password: null));
  }
}
