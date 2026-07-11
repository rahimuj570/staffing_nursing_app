import 'package:flutter/material.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/network/api_service.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/features/shift_features/models/shift_response_model.dart';

class ShiftViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ShiftResponseModel>? shiftResponseModel;

  String? next;
  String? previous;

  Future<void> fetchShifts() async {
    next = null;
    previous = null;
    _isLoading = true;
    notifyListeners();
    NetworkResponseModel responseModel = await ApiService.get(UrlList.shifts);
    if (responseModel.isSuccess) {
      shiftResponseModel = responseModel.responseData['data']
          .map<ShiftResponseModel>((json) => ShiftResponseModel.fromJson(json))
          .toList();
      next = responseModel.responseData['meta']['next'];
      previous = responseModel.responseData['meta']['previous'];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchShifts({required String facility}) async {
    next = null;
    previous = null;
    _isLoading = true;
    notifyListeners();
    NetworkResponseModel responseModel = await ApiService.get(
      UrlList.shifts,
      queryParameters: {'search': facility},
    );
    if (responseModel.isSuccess) {
      shiftResponseModel = responseModel.responseData['data']
          .map<ShiftResponseModel>((json) => ShiftResponseModel.fromJson(json))
          .toList();
      next = responseModel.responseData['meta']['next'];
      previous = responseModel.responseData['meta']['previous'];
    }
    _isLoading = false;
    notifyListeners();
  }
}
