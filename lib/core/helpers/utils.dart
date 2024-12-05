import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/signup_repo.dart';
import 'package:intl/intl.dart';

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

bool isStartDateValid(String startDate) {
  // Normalize the date to YYYY-MM-DD format
  List<String> parts = startDate.split('-');
  String normalizedDate =
      "${parts[0]}-${parts[1].padLeft(2, '0')}-${parts[2].padLeft(2, '0')}";

  // Parse the start date
  DateTime parsedStartDate = DateTime.parse(normalizedDate);

  // Normalize both dates to ignore the time part
  DateTime startDateOnly = DateTime(
      parsedStartDate.year, parsedStartDate.month, parsedStartDate.day);
  DateTime todayOnly = DateTime.now();
  todayOnly = DateTime(todayOnly.year, todayOnly.month, todayOnly.day);

  // Compare the dates
  return startDateOnly.isAfter(todayOnly) ||
      startDateOnly.isAtSameMomentAs(todayOnly);
}

int calculateEarnings(
    {required String startTime,
    required String endTime,
    required int pricePerHour}) {
  log("${startTime} -----${endTime} -------- ${pricePerHour}");
  // Parse the time strings into DateTime objects
  DateTime start = DateTime.parse('2000-01-01 $startTime');
  DateTime end = DateTime.parse('2000-01-01 $endTime');

  // Calculate the difference in hours
  int hours = end.difference(start).inHours;

  // Calculate earnings
  int earnings = hours * pricePerHour;

  return earnings;
}

List<List<int>> extractHours(List<Map<String, dynamic>> timeList) {
  return timeList.map((timeMap) {
    int startTimeHour = int.parse(timeMap['start_time']!.split(':')[0]);
    int endTimeHour = int.parse(timeMap['end_time']!.split(':')[0]);
    return [startTimeHour, endTimeHour];
  }).toList();
}

String? formatTime(String time) {
  try {
    final format = DateFormat("h:mm a"); // 12-hour format with AM/PM
    final parsedTime = DateFormat("HH:mm:ss").parse(time);
    return format.format(parsedTime); // Format into 12-hour AM/PM format
  } on Exception catch (e) {
    log(e.toString());
  }
  return null; // Parse the 24-hour format
}

Future<MultipartFile> imageCompress(XFile image) async {
  final Uint8List? compressedData = await FlutterImageCompress.compressWithList(
    await image.readAsBytes(),
    quality: 70, // Adjust quality for compression
  );
  MultipartFile multipartFile = await MultipartFile.fromBytes(
    compressedData!,
    filename: image.name,
  );
  return multipartFile;
}
