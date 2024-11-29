// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/models/user_auth_model.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/sign_in_repo.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/sign_in_bloc/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  DioConsumer dio;
  SignInCubit(this.dio) : super(SignInState());

  void emailChange(String? value) {
    // get email field changes in state
    emit(state.copyWith(email: value));
  }

  void passwordChange(String? value) {
    // get password field changes in state

    emit(state.copyWith(password: value));
    //
  }

  void sigIn(SignInState user, context) async {
    /* signIn provide app with UserAuthModel
      
      - ARGUEMNTS:
        -SignInState : contains email and password
        -context : to inject in cherryToast
      
      -RETURN:
        - emit UserAuthModel if success
        - cherryToast with error message if fial
    */

    emit(state.copyWith(isLoaind: true));
    try {
      // get user from repo
      UserAuthModel userResponce = await SignInRepo(dio).signIn(user);
      // emit UserAuthModel if user is geted
      emit(state.copyWith(user: userResponce));
      // make laoding false to stop loading
      state.isLoaind = null;
      emit(state.copyWith(isLoaind: null));
    } on ServerException catch (e) {
      state.isLoaind = null;
      emit(state.copyWith(isLoaind: null));
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

  void clearAll() {
    state.password = null;
    state.email = null;
  }
}

//   if (EmailValidator.validate(event.emailValue) == false) {
//     emit(SignInErrorState(errorMassge: 'Please enter valid email address'));
//   } else if (event.passwordValue.length < 9) {
//     emit(SignInErrorState(
//         errorMassge:
//             'Please enter valid passord , it shoud have more than 8 characters'));
//   } else {
//     emit(SignInValidState());
//   }
// });
