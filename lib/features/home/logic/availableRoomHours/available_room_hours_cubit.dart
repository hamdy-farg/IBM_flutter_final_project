import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/features/home/data/repos/booking_repo.dart';
import 'package:meta/meta.dart';

part 'available_room_hours_state.dart';

class AvailableRoomHoursCubit extends Cubit<AvailableRoomHoursState> {
  DioConsumer dio;
  AvailableRoomHoursCubit(this.dio) : super(AvailableRoomHoursInitialState());
  void clear() {
    emit(AvailableRoomHoursInitialState());
  }

  Future<void> getAvailableHours(String date, String roomId) async {
    emit(AvailableRoomHoursLoadingState());
    try {
      List<dynamic> availableHoursList = await BookingUserRepo(dio)
          .getAvailableBooks({"date": date, "room_id": roomId});

      // Convert to a List of Maps with specific typing
      List<Map<String, dynamic>> mapList = availableHoursList.map((item) {
        return Map<String, dynamic>.from(item);
      }).toList();
      log("avialable ${mapList} ");
      emit(AvailableRoomHoursSuccessState(AvailableHoursList: mapList));
    } on ServerException catch (e) {
      emit(AvailableRoomHoursFialState(errorMessage: e.errorModel.message));
    }
  }
}
