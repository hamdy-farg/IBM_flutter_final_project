import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/features/adminControls/logic/bookingCubit/bookings_cubit.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/navigationBar/navigation_bar_state.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit() : super(NavigationBarState());

  Future<void> changeCurrentIndex(int currentIndex) async {
    await getIt<BookingsCubit>().getBookings();
    emit(state.copyWith(currentIndex: currentIndex));
  }
}
