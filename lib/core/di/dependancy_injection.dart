import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/AddNewWorkSpaceCubit/add_new_work_space_cubit.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/sign_in_bloc/sign_in_bloc.dart';
import 'package:ibm_flutter_final_project/features/authentication/logic/singupCubit/sign_up_cubit.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/cubit/get_admin_work_spaces_cubit.dart';

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  getIt.registerLazySingleton(() => DioConsumer(dio: Dio()));
  getIt.registerLazySingleton(
      () => GetAdminWorkSpacesCubit(getIt<DioConsumer>()));
  getIt.registerLazySingleton(() => AddNewWorkSpaceCubit());
  getIt.registerLazySingleton(() => SignUpCubit(getIt<DioConsumer>()));
  getIt.registerLazySingleton(() => SignInCubit(getIt<DioConsumer>()));
}
