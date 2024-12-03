import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/home/data/repos/booking_repo.dart';
import 'package:meta/meta.dart';

part 'available_room_hours_state.dart';

class AvailableRoomHoursCubit extends Cubit<AvailableRoomHoursState> {
  DioConsumer dio;
  AvailableRoomHoursCubit(this.dio) : super(AvailableRoomHoursInitialState());
  Future<void> getAvailableHours(String date, String roomId) async {
    emit(AvailableRoomHoursLoadingState());
    try {
      List<Map<String, String>> availableHoursList = await BookingUserRepo(dio)
          .getAvailableBooks({"date": date, "room_id": roomId});

      emit(AvailableRoomHoursSuccessState(
          AvailableHoursList: availableHoursList));
    } on ServerException catch (e) {
      emit(AvailableRoomHoursFialState(errorMessage: e.errorModel.message));
    }
  }
}
