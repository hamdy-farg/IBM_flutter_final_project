import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final String access_token;
  const ApiInterceptor({required this.access_token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //
    options.headers["Authorization"] = access_token;

    super.onRequest(options, handler);
    //
  }
}
