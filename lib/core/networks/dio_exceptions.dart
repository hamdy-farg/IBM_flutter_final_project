import 'package:dio/dio.dart';
import 'package:ibm_flutter_final_project/core/networks/model/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException({required this.errorModel});
}

void handleDioException(DioException e) {
  // Helper to create a ServerException
  ServerException createServerException(String defaultMessage,
      {int code = 500, dynamic data}) {
    return ServerException(
      errorModel: ErrorModel(
        code: code,
        message: data?['message'] ?? defaultMessage,
      ),
    );
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.badCertificate:
    case DioExceptionType.connectionError:
      throw createServerException(
          "Unable to connect to the server. Please try again later.");

    case DioExceptionType.cancel:
      throw createServerException("Request was cancelled. Please retry.");

    case DioExceptionType.unknown:
      throw createServerException(
          "An unknown error occurred. Please contact support.");

    case DioExceptionType.badResponse:
      if (e.response != null) {
        int statusCode = e.response!.statusCode ?? 500;

        // Handle specific status codes
        switch (statusCode) {
          case 400:
            throw createServerException("Bad request. Please check your input.",
                code: 400, data: e.response?.data);
          case 401:
            throw createServerException("Unauthorized access. Please log in.",
                code: 401, data: e.response?.data);
          case 403:
            throw createServerException(
                "Forbidden. You do not have permission.",
                code: 403,
                data: e.response?.data);
          case 404:
            throw createServerException("Resource not found.",
                code: 404, data: e.response?.data);
          case 409:
            throw createServerException("Conflict occurred. Please retry.",
                code: 409, data: e.response?.data);
          case 422:
            throw createServerException(
                "Invalid data submitted. Check your input.",
                code: 422,
                data: e.response?.data);
          case 500:
          case 504:
            throw createServerException("Server error. Please try again later.",
                code: statusCode, data: e.response?.data);
          default:
            throw createServerException("An error occurred. Please try again.",
                code: statusCode, data: e.response?.data);
        }
      }
      throw createServerException("Bad response from server.");

    default:
      throw createServerException("Unexpected error occurred. Please retry.");
  }
}


// void handleDioException(DioException e) {
//   switch (e.type) {
//     case DioExceptionType.connectionTimeout:
//       throw ServerException(
//           errorModel: ErrorModel(
//         code: 401,
//         message: e.message ?? "an error accured while connecting server",
//       ));
//     // TODO: Handle this case.
//     case DioExceptionType.sendTimeout:
//       throw ServerException(
//           errorModel: ErrorModel(
//         code: 401,
//         message: e.message ?? "an error accured while connecting server",
//       ));
//     // TODO: Handle this case.
//     case DioExceptionType.receiveTimeout:
//       throw ServerException(
//           errorModel: ErrorModel(
//         code: 401,
//         message: e.message ?? "an error accured while connecting server",
//       ));
//     // TODO: Handle this case.
//     case DioExceptionType.badCertificate:
//       throw ServerException(
//           errorModel: ErrorModel(
//         code: 401,
//         message: e.message ?? "an error accured while connecting server",
//       ));

//     // TODO: Handle this case.
//     case DioExceptionType.cancel:
//       throw ServerException(
//           errorModel: ErrorModel(
//         code: 401,
//         message: e.message ?? "an error accured while connecting server",
//       ));
//     // TODO: Handle this case.
//     case DioExceptionType.unknown:
//       throw ServerException(
//           errorModel: ErrorModel(
//         code: 401,
//         message: e.message ?? "an error accured while connecting server",
//       ));
//     // TODO: Handle this case.
//     case DioExceptionType.connectionError:
//       throw ServerException(
//           errorModel: ErrorModel(
//         code: 401,
//         message: e.message ?? "an error accured while connecting server",
//       ));
//     case DioExceptionType.badResponse:
//       switch (e.response?.statusCode) {
//         case 400: // Bad request
//           throw ServerException(
//               errorModel: ErrorModel.fromMap(e.response!.data));
//         case 401: //unauthorized
//           throw ServerException(
//               errorModel: ErrorModel.fromMap(e.response!.data));
//         case 403: //forbidden
//           throw ServerException(
//               errorModel: ErrorModel.fromMap(e.response!.data));
//         case 404: //not found
//           throw ServerException(
//               errorModel: ErrorModel.fromMap(e.response!.data));
//         case 409: //cofficient
//           throw ServerException(
//               errorModel: ErrorModel.fromMap(e.response!.data));
//         case 500: //cofficient
//           throw ServerException(
//               errorModel: ErrorModel.fromMap(e.response!.data));
//         case 422: //  Unprocessable Entity
//           throw ServerException(
//               errorModel: ErrorModel.fromMap(e.response!.data));
//         case 504: // Server exception
//           throw ServerException(
//               errorModel: ErrorModel.fromMap(e.response!.data));
//       }

//     // TODO: Handle this case.
//   }
// }
