import 'dart:io';

import 'package:dio/dio.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/app/services/toast_service.dart';

class DioExceptionHandler {
  static NetworkResponseModel handle(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        ToastService.showError("Connection timeout");
        return NetworkResponseModel(
          isSuccess: false,
          statusCode: -1,
          message: "Connection timeout",
        );

      case DioExceptionType.sendTimeout:
        ToastService.showError("Request timeout");
        return NetworkResponseModel(
          isSuccess: false,
          statusCode: -1,
          message: "Request timeout",
        );

      case DioExceptionType.receiveTimeout:
        ToastService.showError("Response timeout");
        return NetworkResponseModel(
          isSuccess: false,
          statusCode: -1,
          message: "Response timeout",
        );

      case DioExceptionType.connectionError:
        ToastService.showError("No internet connection");
        return NetworkResponseModel(
          isSuccess: false,
          statusCode: -1,
          message: "No internet connection",
        );

      case DioExceptionType.cancel:
        ToastService.showError("Request cancelled");
        return NetworkResponseModel(
          isSuccess: false,
          statusCode: -1,
          message: "Request cancelled",
        );

      case DioExceptionType.badCertificate:
        ToastService.showError("Bad certificate");
        return NetworkResponseModel(
          isSuccess: false,
          statusCode: -1,
          message: "Bad certificate",
        );

      case DioExceptionType.badResponse:
        ToastService.showError(_extractMessage(exception));
        return NetworkResponseModel(
          isSuccess: false,
          statusCode: exception.response?.statusCode ?? -1,
          responseData: exception.response?.data,
          message: _extractMessage(exception),
        );

      case DioExceptionType.unknown:
        if (exception.error is SocketException) {
          ToastService.showError("No internet connection");
          return NetworkResponseModel(
            isSuccess: false,
            statusCode: -1,
            message: "No internet connection",
          );
        }

        ToastService.showError(_extractMessage(exception));
        return NetworkResponseModel(
          isSuccess: false,
          statusCode: -1,
          message: exception.message,
        );
      case DioExceptionType.transformTimeout:
        if (exception.error is SocketException) {
          return NetworkResponseModel(
            isSuccess: false,
            statusCode: -1,
            message: "Transform timeout",
          );
        }

        return NetworkResponseModel(
          isSuccess: false,
          statusCode: -1,
          message: exception.message,
        );
    }
  }

  static String _extractMessage(DioException exception) {
    final responseData = exception.response?.data;

    if (responseData is Map<String, dynamic>) {
      return responseData["message"]?.toString() ?? "Something went wrong";
    }

    return "Something went wrong";
  }
}
