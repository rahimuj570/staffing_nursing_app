import 'package:dio/dio.dart';
import 'package:staffing/app/network/dio_client.dart';

class RefreshInterceptor extends Interceptor {
  final Dio dio;
  bool _isRefreshing = false;
  Future<bool>? _refreshFuture;

  RefreshInterceptor(this.dio);

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    // final success = await _refreshToken();
    bool success;
    if (_isRefreshing) {
      success = await _refreshFuture!;
    } else {
      _isRefreshing = true;

      try {
        _refreshFuture = _refreshToken();
        success = await _refreshFuture!;
      } finally {
        _isRefreshing = false;
        _refreshFuture = null;
      }
    }

    if (!success) {
      return handler.next(err);
    }

    final token = ""; //await AuthPrefsService().getToken();

    err.requestOptions.headers["Authorization"] = "Bearer $token";

    final response = await dio.fetch(err.requestOptions);

    return handler.resolve(response);
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = '';
      // await AuthPrefsService()
      //     .getRefreshToken();

      if (refreshToken == null) {
        return false;
      }

      final refreshDio = DioClient.createRefreshDio();

      final response = await refreshDio.post(
        "https://api.blacklandcestry.com/api/refresh/",
        data: {"refresh_token": refreshToken},
      );

      if (response.statusCode == 200) {
        // await AuthPrefsService().saveToken(
        //   response.data["token"],
        // );

        // await AuthPrefsService()
        //     .saveRefreshToken(
        //   response.data["refreshToken"],
        // );

        return true;
      }
    } catch (_) {}

    return false;
  }
}
