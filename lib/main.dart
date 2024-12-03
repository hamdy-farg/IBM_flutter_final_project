import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/routing/app_router.dart';
import 'package:ibm_flutter_final_project/desk_app.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/signup_repo.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/cubit/get_admin_work_spaces_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();

  await CacheHelper().init();
  String? loginAs =
      CacheHelper.sharedPreferences.getString(cacheHelperString.role);
  if (loginAs == "admin") {
    final cubit = getIt<GetAdminWorkSpacesCubit>();
    await cubit.fetchData();
  } else if (loginAs == "client") {
  } else {}

  runApp(DeskApp(
    appRouter: AppRouter(),
  ));
}
