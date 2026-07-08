import 'package:dio/dio.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/network/interceptors/auth_interceptor.dart';
import 'package:staffing/app/network/interceptors/logger_interceptor.dart';
import 'package:staffing/app/network/interceptors/refresh_interceptor.dart';

class DioClient {
  DioClient._() {
    dio.interceptors.addAll([
      LoggerInterceptor(),
      AuthInterceptor(),
      RefreshInterceptor(dio),
    ]);
  }

  static final DioClient _instance = DioClient._();

  factory DioClient() => _instance;

  final Dio dio = _createDio();

  static Dio _createDio() {
    return Dio(
      BaseOptions(
        baseUrl: UrlList.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: const {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        responseType: ResponseType.json,
      ),
    );
  }

  static Dio createRefreshDio() {
    return _createDio();
  }
}
