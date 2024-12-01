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

Map<String, double>? extractLatLong(String url) {
  try {
    // Parse the URL
    final uri = Uri.parse(url);

    // Get the `q` query parameter
    final coordinates = uri.queryParameters['q'];
    if (coordinates != null) {
      // Split the coordinates into latitude and longitude
      final latLong = coordinates.split(',');

      // Parse and return the latitude and longitude as doubles
      if (latLong.length == 2) {
        final latitude = double.parse(latLong[0]);
        final longitude = double.parse(latLong[1]);
        return {'lat': latitude, 'long': longitude};
      }
    }
  } catch (e) {
    print('Error parsing coordinates: $e');
  }

  return null; // Return null if parsing fails
}
