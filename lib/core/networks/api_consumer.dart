abstract class ApiConsumer {
  Future<dynamic> get(String path, String accessToken,
      {Map<String, dynamic>? queryParameters});

  // post method
  Future<dynamic> post(
    String path,
    String? accessToken, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });

  // update method
  Future<dynamic> put(
    String path,
    String accessToken, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });

  // delete method
  Future<dynamic> delete(
    String path,
    String accessToken, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
}
