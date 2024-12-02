import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/routing/app_router.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/signup_repo.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/cubit/get_admin_work_spaces_cubit.dart';

String intiRoutes() {
  String? loginAs =
      CacheHelper.sharedPreferences.getString(cacheHelperString.role);
  log("$loginAs");
  if (loginAs == "admin") {
    final cubit = getIt<GetAdminWorkSpacesCubit>();
    cubit.fetchData();
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
        initialRoute: intiRoutes(), //! set your initial route
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
