import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/networks/model/error_model.dart';
import 'package:ibm_flutter_final_project/features/User/data/repos/edit_profile_repo.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/sign_in_repo.dart';
import 'package:meta/meta.dart';

part 'verify_user_state.dart';

class VerifyUserCubit extends Cubit<VerifyUserState> {
  DioConsumer dioConsumer;
  VerifyUserCubit(this.dioConsumer) : super(VerifyUserInitial());
  Future<void> verifiyUser() async {
    emit(VerifyUserLoading());
    
    try {
      log("hiiiiiiiiiiiiiiiii1");

      String? isConfirmed = CacheHelper.sharedPreferences
          .getString(cacheHelperString.is_confirmed);
      log("$isConfirmed");

      if (isConfirmed == "False") {
        String? savedDatetime = CacheHelper.sharedPreferences
            .getString(cacheHelperString.savedDateTime);
        log("$isConfirmed");
        if (savedDatetime != null) {
          compareDateTime(savedDatetime);
        } else {
          saveCurrentDateTime();
        }
      }
      log("hiiiiiiiiiiiiiiiii2");

      bool is_email_sent = await EditProfileRepo(dio: dioConsumer).verifyUser();
      emit(VerifyUserSuccess());
    } on ServerException catch (e) {
      log("hiiiiiiiiiiiiiiiii");
      emit(VerifyUserFial(message: e.errorModel.message));
    }
  }
}

Future<void> saveCurrentDateTime() async {
  // Get the current DateTime from the device
  DateTime currentDateTime = DateTime.now();
  final savedDateTime = await CacheHelper.sharedPreferences.setString(
      cacheHelperString.savedDateTime, currentDateTime.toIso8601String());

  // Save the current DateTime as a string (ISO 8601 format)
  print("Current DateTime saved: ${currentDateTime.toIso8601String()}");
}

Future<void> compareDateTime(String savedDate) async {
  DateTime savedDateTime = DateTime.parse(savedDate);
  DateTime currentDateTime = DateTime.now();

  if (savedDateTime.isBefore(savedDateTime.add(Duration(minutes: 3)))) {
    throw ServerException(
        errorModel: ErrorModel(
            message:
                "wait for ${currentDateTime.difference(savedDateTime)} to send again",
            status: "True",
            code: 400));
    // Perform your pass logic here
  } else {
    await CacheHelper.sharedPreferences.remove(cacheHelperString.savedDateTime);
  }
}
