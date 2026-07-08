import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:staffing/app/network/logger_model.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LoggerModel(
      url: options.uri.toString(),
      statusCode: 0,
      body: _formatBody(options.data),
    ).printLog();

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final isSuccess = [200, 201, 202, 204].contains(response.statusCode);

    LoggerModel(
      url: response.requestOptions.uri.toString(),
      statusCode: response.statusCode ?? 0,
      body: _formatBody(response.data),
    ).printLog(isError: !isSuccess);

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LoggerModel(
      url: err.requestOptions.uri.toString(),
      statusCode: err.response?.statusCode ?? -1,
      body: _formatBody(err.response?.data ?? err.message),
    ).printLog(isError: true);

    handler.next(err);
  }

  String _formatBody(dynamic body) {
    if (body == null) return "";

    try {
      return const JsonEncoder.withIndent("  ").convert(body);
    } catch (_) {
      return body.toString();
    }
  }
}
