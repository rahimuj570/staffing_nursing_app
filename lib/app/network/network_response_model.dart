class NetworkResponseModel {
  final bool isSuccess;
  final int statusCode;
  final dynamic responseData;
  final String? message;

  const NetworkResponseModel({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.message,
  });
}
