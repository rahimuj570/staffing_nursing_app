import 'package:dio/dio.dart';
import 'package:staffing/app/network/dio_client.dart';
import 'package:staffing/app/network/dio_exception_handler.dart';
import 'package:staffing/app/network/network_response_model.dart';

class ApiService {
  ApiService._();

  static final Dio _dio = DioClient().dio;

  static Future<NetworkResponseModel> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );

      return NetworkResponseModel(
        isSuccess:
            response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300,
        statusCode: response.statusCode ?? -1,
        responseData: response.data,
        message: response.data["message"],
      );
    } on DioException catch (e) {
      return DioExceptionHandler.handle(e);
    }
  }

  static Future<NetworkResponseModel> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return NetworkResponseModel(
        isSuccess:
            response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300,
        statusCode: response.statusCode ?? -1,
        responseData: response.data,
        message: response.data["message"],
      );
    } on DioException catch (e) {
      return DioExceptionHandler.handle(e);
    }
  }

  static Future<NetworkResponseModel> put(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(path, data: data, options: options);

      return NetworkResponseModel(
        isSuccess:
            response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300,
        statusCode: response.statusCode ?? -1,
        responseData: response.data,
        message: response.data["message"],
      );
    } on DioException catch (e) {
      return DioExceptionHandler.handle(e);
    }
  }

  static Future<NetworkResponseModel> patch(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(path, data: data, options: options);

      return NetworkResponseModel(
        isSuccess:
            response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300,
        statusCode: response.statusCode ?? -1,
        responseData: response.data,
        message: response.data["message"],
      );
    } on DioException catch (e) {
      return DioExceptionHandler.handle(e);
    }
  }

  static Future<NetworkResponseModel> delete(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(path, data: data, options: options);

      return NetworkResponseModel(
        isSuccess:
            response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300,
        statusCode: response.statusCode ?? -1,
        responseData: response.data,
        message: response.data["message"],
      );
    } on DioException catch (e) {
      return DioExceptionHandler.handle(e);
    }
  }
}
