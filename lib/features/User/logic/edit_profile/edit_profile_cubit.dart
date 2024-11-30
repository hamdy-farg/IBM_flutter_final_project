import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/User/data/repos/edit_profile_repo.dart';
import 'package:ibm_flutter_final_project/features/User/logic/edit_profile/edit_profile_state.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/sign_in_repo.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final DioConsumer dio;
  EditProfileCubit(this.dio) : super(EditProfileState());
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void fetchCachedData() {
    fNameController.text =
        CacheHelper.sharedPreferences.getString(cacheHelperString.fName) ?? "";
    lNameController.text =
        CacheHelper.sharedPreferences.getString(cacheHelperString.lName) ?? "";
    emailController.text =
        CacheHelper.sharedPreferences.getString(cacheHelperString.email) ?? '';
    phoneController.text = CacheHelper.sharedPreferences
            .getString(cacheHelperString.phoneNumber) ??
        "";
  }

  void fetchApiData(EditProfileState profile, BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    try {
      log("his his8 ${profile.image} ${profile.email} ");
      if (profile.image == null &&
          profile.email == null &&
          profile.lName == null &&
          profile.fName == null &&
          profile.phone == null) {
        CherryToast.error(
          title: const Text("you have to change any thing to update"),
        ).show(context);
        state.isLoading = null;
        emit(
          state.copyWith(isLoading: null),
        );
      } else {
        final profileResponce =
            await EditProfileRepo(dio: dio).editProfile(profile);
        emit(state.copyWith(profile: profileResponce));
        state.isLoading = null;
        emit(
          state.copyWith(isLoading: null),
        );
        CherryToast.success(
          title: const Text("your account updated successfully"),
        ).show(context);
      }
    } on ServerException catch (e) {
      CherryToast.error(
        title: Text(e.errorModel.message),
      ).show(context);
      state.isLoading = null;
      emit(
        state.copyWith(isLoading: null),
      );
    }
  }

  void imageChange(XFile? image) {
    emit(state.copyWith(image: image));
  }

  void fNameChange(String? value) {
    log("$value");
    emit(state.copyWith(fName: value));
  }

  void lNameChange(String? value) {
    log("$value");

    emit(state.copyWith(lName: value));
  }

  void emailChange(String? value) {
    log("$value");

    emit(state.copyWith(email: value));
  }

  void phoneChange(String? value) {
    log("$value");
    emit(state.copyWith(phone: value));
  }

  void clearAll() {
    state.image = null;
    state.email = null;
    state.fName = null;
    state.lName = null;
    state.phone = null;
    emit(state.copyWith(
        image: null, email: null, fName: null, lName: null, phone: null));
  }
}
