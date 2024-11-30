import 'package:dio/dio.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:ibm_flutter_final_project/features/User/logic/edit_profile/edit_profile_state.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/sign_in_repo.dart';

class EditProfileRepo {
  DioConsumer dio;
  EditProfileRepo({
    required this.dio,
  });

  Future<EditProfileState> editProfile(EditProfileState profile) async {
    final refreshTokens =
        CacheHelper.sharedPreferences.getString(cacheHelperString.refreshToken);

    try {
      MultipartFile? multipartFile;
      if (profile.image != null) {
        multipartFile = await MultipartFile.fromFile(
          profile.image!.path,
          filename: profile.image!.name,
        );
      }
      final Map<String, dynamic> accessTokenMap =
          await dio.post(EndPoint.refresh, "Bearer $refreshTokens");
      final profileEditResponce = await dio.put(
          EndPoint.editProfile, "Bearer ${accessTokenMap["access_token"]}",
          data: profile.toMap(multipartFile), isFormData: true);

      EditProfileState profileResponce =
          EditProfileState.fromMap(profileEditResponce);

      CacheHelper.sharedPreferences
          .setString(cacheHelperString.image, profileResponce.imageLink ?? "");
      CacheHelper.sharedPreferences
          .setString(cacheHelperString.fName, profileResponce.fName ?? "");
      CacheHelper.sharedPreferences
          .setString(cacheHelperString.lName, profileResponce.lName ?? "");
      CacheHelper.sharedPreferences
          .setString(cacheHelperString.email, profileResponce.email ?? "");
      CacheHelper.sharedPreferences
          .setString(cacheHelperString.image, profileResponce.imageLink ?? "");
      CacheHelper.sharedPreferences.setString(
          cacheHelperString.phoneNumber, profileResponce.phone ?? "");

      

      return profileResponce;
    } on ServerException catch (e) {
      rethrow;
    }
  }
}
