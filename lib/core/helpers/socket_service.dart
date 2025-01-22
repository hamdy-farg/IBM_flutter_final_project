import 'dart:developer';

import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/cach_helper.dart';
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:ibm_flutter_final_project/features/authentication/data/repos/sign_in_repo.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  Future<void> initialize() async {
    try {
      String access_token = await getAccessToken(getIt<DioConsumer>());

      socket = IO.io(EndPoint.baseUri, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'auth': {'token': access_token},
      });

      socket.connect();

      socket.onConnect((_) => log('Connected to server'));
      socket.onDisconnect((_) => log('Disconnected to server'));
      socket.onConnectError((error) => log("Connection Error: $error"));
      socket.onError((error) => log("Socket Error to server: $error"));
      socket.onReconnect((_) => log('Reconnected to the server to server'));
      socket.onReconnectAttempt((_) => log('Reconnection attempt to server'));
      socket.onReconnectFailed((_) => log('Reconnection failed to server'));
    } catch (e) {
      log("Socket initialization failed: $e");
    }
  }

  Future<void> joinRoom(String room_id, String date) async {
    try {
      String access_token = await getAccessToken(getIt<DioConsumer>());
      socket.emit("join_room",
          {"room_id": room_id, "date": date, "token": access_token});
    } catch (e) {
      log("Failed to join room: $e");
    }
  }

  void leaveRoom(String room_id, String date) {
    try {
      socket.emit("leave_room", {"room_id": room_id, "date": date});
    } catch (e) {
      log("Failed to leave room: $e");
    }
  }

  void joinToVerify() {
    print("joining");
    final email =
        CacheHelper.sharedPreferences.getString(cacheHelperString.email);
    try {
      socket.emit("join_to_verify", {"email": email});
    } catch (e) {
      log("Failed to leave room: $e");
    }
  }

  void leaveToVerify() {
    final email =
        CacheHelper.sharedPreferences.getString(cacheHelperString.email);
    try {
      socket.emit("leave_to_verify", {"email": email});
    } catch (e) {
      log("Failed to leave room: $e");
    }
  }

  void listenForVerifcationUpdates(Function(Map<String, dynamic>) onUpdate) {
    try {
      socket.on("verification_updates", (data) => onUpdate(data));
    } catch (e) {
      log("Failed to listen for updates: $e");
    }
  }

  void listenForUpdates(Function(Map<String, dynamic>) onUpdate) {
    try {
      socket.on("availability_updated", (data) => onUpdate(data));
    } catch (e) {
      log("Failed to listen for updates: $e");
    }
  }

  void disconnect() {
    try {
      socket.disconnect();
    } catch (e) {
      log("Failed to disconnect: $e");
    }
  }
}
