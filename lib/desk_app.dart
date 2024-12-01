import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/routing/app_router.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/signup_repo.dart';

String intiRoutes() {
  String? loginAs =
      CacheHelper.sharedPreferences.getString(cacheHelperString.role);
  log("$loginAs");
  if (loginAs == "admin") {
    return Routes.workspaceStatus;
  } else if (loginAs == "client") {
    return Routes.workspaceStatus;
  } else {
    return Routes.loginScreen;
  }
}

class DeskApp extends StatelessWidget {
  final AppRouter appRouter;
  const DeskApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doc app',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: Routes.addNewWorkSpace, //! set your initial route
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
