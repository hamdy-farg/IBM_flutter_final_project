import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
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
