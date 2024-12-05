import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/features/adminControls/logic/bookingCubit/bookings_cubit.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/signup_repo.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/navigationBar/navigation_bar_state.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit() : super(NavigationBarState());

  Future<void> changeCurrentIndex(int currentIndex) async {
    final role =
        CacheHelper.sharedPreferences.getString(cacheHelperString.role);
    if (currentIndex == 2) {
      emit(state.copyWith(currentIndex: currentIndex));

      role == "admin"
          ? await getIt<BookingsCubit>().getBookings()
          : print("object");
    } else if (currentIndex == 1) {
      emit(state.copyWith(currentIndex: currentIndex));

      log("current index is ${currentIndex}");
      // if (role == "admin") {
      // await getIt<GetAdminWorkSpacesCubit>().fetchData();
      // }
      // await getIt<HomeWorkSpaceCubit>().getWorkSpace();
      // await getIt<HomeRoomsCubit>().getRooms();
    } else {}
    emit(state.copyWith(currentIndex: currentIndex));
  }
}
