import 'package:dio/dio.dart';

import 'dio_client.dart';

class ApiService {
  ApiService._();

  static final Dio _dio = DioClient().dio;

  static Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  static Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  static Future<Response> put(String path, {dynamic data, Options? options}) {
    return _dio.put(path, data: data, options: options);
  }

  static Future<Response> patch(String path, {dynamic data, Options? options}) {
    return _dio.patch(path, data: data, options: options);
  }

  static Future<Response> delete(
    String path, {
    dynamic data,
    Options? options,
  }) {
    return _dio.delete(path, data: data, options: options);
  }
}
