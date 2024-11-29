import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ibm_flutter_final_project/core/networks/api_consumer.dart';
import 'package:ibm_flutter_final_project/core/networks/api_interceptor.dart';
import 'package:ibm_flutter_final_project/core/networks/dio_exceptions.dart';
import 'package:ibm_flutter_final_project/core/networks/end_point.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConsumer extends ApiConsumer {
  late final Dio dio;
  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.interceptors.add(PrettyDioLogger());

    dio.interceptors.add(const ApiInterceptor(access_token: ""));
    dio.interceptors.add(PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }
  @override
  Future delete(
    String path,
    String? accessToken, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      if (accessToken != null) {
        dio.interceptors.add(ApiInterceptor(access_token: accessToken));
      }
      final responce = await dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return responce.data;
    } on DioException catch (e) {
      log("$e");
      handleDioException(e);
    }
  }

  @override
  Future get(
    String path,
    String? accessToken, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (accessToken != null) {
        dio.interceptors.add(ApiInterceptor(access_token: accessToken));
      }
      final responce = await dio.get(
        path,
        queryParameters: queryParameters,
      );
      return responce.data;
    } on DioException catch (e) {
      log("$e");
      handleDioException(e);
    }
  }

  @override
  Future post(
    String path,
    String? accessToken, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    if (accessToken != null) {
      dio.interceptors.add(ApiInterceptor(access_token: accessToken));
    }
    try {
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future put(
    String path,
    String? accessToken, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      if (accessToken != null) {
        dio.interceptors.add(ApiInterceptor(access_token: accessToken));
      }
      final response = await dio.put(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
