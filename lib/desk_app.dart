import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/routing/app_router.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        // initialRoute: ,//! set your initial route
        initialRoute: Routes.addNewWorkSpace,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
