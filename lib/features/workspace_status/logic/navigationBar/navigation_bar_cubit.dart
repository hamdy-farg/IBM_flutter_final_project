import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/navigationBar/navigation_bar_state.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit() : super(NavigationBarState());

  void changeCurrentIndex(int currentIndex) {
    emit(state.copyWith(currentIndex: currentIndex));
  }
}
