import 'package:logger/logger.dart';

class LoggerModel {
  final String url;
  final int statusCode;
  final dynamic body;

  LoggerModel({
    required this.url,
    required this.statusCode,
    required this.body,
  });

  final Logger _log = Logger();

  void printLog({bool isError = false}) {
    if (isError) {
      _log.e('URL=> $url \nStatus_Code=> $statusCode \nBody=> $body');
    } else {
      _log.i('URL=> $url \nStatus_Code=> $statusCode \nBody=> $body');
    }
  }
}
