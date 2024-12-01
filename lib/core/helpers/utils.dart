import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/signup_repo.dart';

void logout(BuildContext context) {
  context.pushReplacementNamed(Routes.loginScreen);
  log("${CacheHelper.sharedPreferences.remove(cacheHelperString.role)}");
  log("${CacheHelper.sharedPreferences.remove(cacheHelperString.image)}");
  log("${CacheHelper.sharedPreferences.remove(cacheHelperString.fName)}");
  log("${CacheHelper.sharedPreferences.remove(cacheHelperString.lName)}");
  log("${CacheHelper.sharedPreferences.remove(cacheHelperString.email)}");
}

Future<String> getAccessToken(DioConsumer dio) async {
  try {
    String? refreshToken =
        CacheHelper.sharedPreferences.getString(cacheHelperString.refreshToken);
    if (refreshToken != null) {
      Map<String, dynamic> accessTokenResponce =
          await dio.post("refresh", "Bearer $refreshToken");
      String accessToken = "Bearer ${accessTokenResponce["access_token"]}";
      return accessToken;
    } else {
      return "null";
    }
  } on ServerException catch (e) {
    rethrow;
  }
}
