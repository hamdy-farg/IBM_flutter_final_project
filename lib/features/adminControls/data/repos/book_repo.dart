import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:ibm_flutter_final_project/features/adminControls/data/models/book.dart';

class BookingsAdminRepo {
  DioConsumer dio;
  BookingsAdminRepo(this.dio);
  Future<Map<String, String>> changeSatusOfBookings(BookModel bookModel) async {
    try {
      String accessToken = await getAccessToken(dio);

      Map<String, dynamic> BookingsResoponce = await dio.put(
          EndPoint.updateBookStatus, accessToken,
          data: {"booked_id": bookModel.id, "status": bookModel.status},
          isFormData: true);

      return {"success": BookingsResoponce["status"]};
    } on ServerException catch (e) {
      rethrow;
    }
  }

  Future<List<BookModel>> getBookings() async {
    try {
      String accessToken = await getAccessToken(dio);

      Map<String, dynamic> BookingsResoponce =
          await dio.get(EndPoint.adminBooks, accessToken);
      List<BookModel> BookdingList = (BookingsResoponce["roomBookings"] as List)
          .map((book) => BookModel.fromMap(book))
          .toList();

      return BookdingList;
    } on ServerException catch (e) {
      rethrow;
    }
  }
}
