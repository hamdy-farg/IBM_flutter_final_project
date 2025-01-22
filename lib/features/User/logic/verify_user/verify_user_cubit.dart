import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/helpers/socket_service.dart';
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
      String? isConfirmed = CacheHelper.sharedPreferences
          .getString(cacheHelperString.is_confirmed);
      log("$isConfirmed");

      if (isConfirmed == "False") {
        String? savedDatetime = CacheHelper.sharedPreferences
            .getString(cacheHelperString.savedDateTime);
        log("$isConfirmed");
        if (savedDatetime != null) {
          await compareDateTime(savedDatetime);
        } else {
          saveCurrentDateTime();
        }
      }
      final email =
          CacheHelper.sharedPreferences.getString(cacheHelperString.email);
      SocketService socketService;
      socketService = SocketService();
      await socketService.initialize();
      socketService.joinToVerify();
      socketService.listenForVerifcationUpdates((data) {
        CacheHelper.sharedPreferences
            .setString(cacheHelperString.is_confirmed, data["confirmed"]);
        socketService.leaveToVerify();
        emit(VerifyUserSuccess());
      });

      bool is_email_sent = await EditProfileRepo(dio: dioConsumer).verifyUser();
      emit(VerifyUserSuccess());
    } on ServerException catch (e) {
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
}

Future<void> compareDateTime(String savedDate) async {
  DateTime savedDateTime = DateTime.parse(savedDate);
  DateTime currentDateTime = DateTime.now();

  // Calculate the target time (saved time + 3 minutes)
  DateTime targetDateTime = savedDateTime.add(Duration(minutes: 3));

  if (currentDateTime.isBefore(targetDateTime)) {
    // Calculate the wait time correctly
    final waitTime = targetDateTime.difference(currentDateTime);

    // Throw a ServerException with a clear error message
    throw ServerException(
      errorModel: ErrorModel(
        message:
            "Please wait for ${waitTime.inMinutes} minutes and ${waitTime.inSeconds % 60} seconds to resend.",
        status: "True",
        code: 400,
      ),
    );
  } else {
    // Clear saved datetime after the 3-minute window has passed
    await CacheHelper.sharedPreferences.remove(cacheHelperString.savedDateTime);
  }
}
