import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:ibm_flutter_final_project/features/home/data/model/Booking_model.dart';

class BookingUserRepo {
  final DioConsumer dio;
  const BookingUserRepo(this.dio);
  Future<UserBookingModel> makeBooking(UserBookingModel booking) async {
    try {
      String accessToken = await getAccessToken(dio);

      Map<String, dynamic> getWorkSpaceResponce = await dio.post(
        EndPoint.userMakeBook,
        accessToken,
        data: booking.toMap(),
      );

      UserBookingModel bookingResponce =
          UserBookingModel.fromMap(getWorkSpaceResponce);
      return bookingResponce;
    } on ServerException catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, String>>> getAvailableBooks(
      Map<String, String> data) async {
    try {
      String accessToken = await getAccessToken(dio);

      List<Map<String, String>> getWorkSpaceResponce = await dio.post(
          EndPoint.getAvialbleBooks, accessToken,
          data: data, isFormData: true);

      return getWorkSpaceResponce;
    } on ServerException catch (e) {
      rethrow;
    }
  }
}
