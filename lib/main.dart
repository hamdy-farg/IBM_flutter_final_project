import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/routing/app_router.dart';
import 'package:ibm_flutter_final_project/desk_app.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/signup_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();

  await setupGetIt();
  runApp(DeskApp(

    appRouter: AppRouter(),
  ));
}
