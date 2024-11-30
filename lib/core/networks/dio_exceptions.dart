import 'package:dio/dio.dart';
import 'package:ibm_flutter_final_project/core/networks/model/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException({required this.errorModel});
}

void handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
          errorModel: ErrorModel(
        code: 401,
        message: e.message!,
      ));
    // TODO: Handle this case.
    case DioExceptionType.sendTimeout:
      throw ServerException(
          errorModel: ErrorModel(
        code: 401,
        message: e.message!,
      ));
    // TODO: Handle this case.
    case DioExceptionType.receiveTimeout:
      throw ServerException(
          errorModel: ErrorModel(
        code: 401,
        message: e.message!,
      ));
    // TODO: Handle this case.
    case DioExceptionType.badCertificate:
      throw ServerException(
          errorModel: ErrorModel(
        code: 401,
        message: e.message!,
      ));
    // TODO: Handle this case.
    case DioExceptionType.badResponse:
      throw ServerException(
          errorModel: ErrorModel(
        code: 401,
        message: e.response!.data["message"],
      ));
    // TODO: Handle this case.
    case DioExceptionType.cancel:
      throw ServerException(
          errorModel: ErrorModel(
        code: 401,
        message: e.message!,
      ));
    // TODO: Handle this case.
    case DioExceptionType.unknown:
      throw ServerException(
          errorModel: ErrorModel(
        code: 401,
        message: e.message!,
      ));
    // TODO: Handle this case.
    case DioExceptionType.connectionError:
      throw ServerException(
          errorModel: ErrorModel(
        code: 401,
        message: e.message!,
      ));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
        case 401: //unauthorized
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
        case 403: //forbidden
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
        case 404: //not found
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
        case 409: //cofficient
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
        case 500: //cofficient
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
        case 422: //  Unprocessable Entity
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
        case 504: // Server exception
          throw ServerException(
              errorModel: ErrorModel.fromMap(e.response!.data));
      }

    // TODO: Handle this case.
  }
}
