import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ibm_flutter_final_project/core/helpers/socket_service.dart';
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
//
      SocketService socketService;
      socketService = SocketService();
      await socketService.initialize();
      await socketService.joinRoom(roomId, date);
      log("dataaa: $roomId");

//

      // Convert to a List of Maps with specific typing
      List<Map<String, dynamic>> mapList = availableHoursList.map((item) {
        return Map<String, dynamic>.from(item);
      }).toList();

      socketService.listenForUpdates((data) {
        emit(AvailableRoomHoursLoadingState());
        try {
          // Ensure data["available_slots"] is a list
          List<Map<String, dynamic>> newMapList =
              (data["available_slots"] as List).map((item) {
            if (item is Map<String, dynamic>) {
              return item;
            } else {
              return Map<String, dynamic>.from(item as Map); // Force conversion
            }
          }).toList();

          emit(AvailableRoomHoursSuccessState(AvailableHoursList: newMapList));
        } catch (e, stackTrace) {
          log('Error while processing available_slots: $e');
          log(stackTrace.toString());
          emit(AvailableRoomHoursFialState(errorMessage: e.toString()));
        }
      });

      log("avialable ${mapList} ");
      emit(AvailableRoomHoursSuccessState(AvailableHoursList: mapList));
    } on ServerException catch (e) {
      emit(AvailableRoomHoursFialState(errorMessage: e.errorModel.message));
    }
  }
}
