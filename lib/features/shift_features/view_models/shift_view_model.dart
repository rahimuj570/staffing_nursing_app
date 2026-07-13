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
  bool isFilteredResult = false;
  int totalPages = 1;

  Future<void> fetchShifts() async {
    isFilteredResult = false;
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
      totalPages = responseModel.responseData['meta']['total_pages'];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchNextPage() async {
    _isLoading = true;
    notifyListeners();
    NetworkResponseModel responseModel = await ApiService.get(next!);
    if (responseModel.isSuccess) {
      shiftResponseModel!.addAll(
        responseModel.responseData['data']
            .map<ShiftResponseModel>(
              (json) => ShiftResponseModel.fromJson(json),
            )
            .toList(),
      );
      next = responseModel.responseData['meta']['next'];
      previous = responseModel.responseData['meta']['previous'];
      totalPages = responseModel.responseData['meta']['total_pages'];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPreviousPage() async {
    _isLoading = true;
    notifyListeners();
    NetworkResponseModel responseModel = await ApiService.get(previous!);
    if (responseModel.isSuccess) {
      shiftResponseModel!.addAll(
        responseModel.responseData['data']
            .map<ShiftResponseModel>(
              (json) => ShiftResponseModel.fromJson(json),
            )
            .toList(),
      );
      next = responseModel.responseData['meta']['next'];
      previous = responseModel.responseData['meta']['previous'];
      totalPages = responseModel.responseData['meta']['total_pages'];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<NetworkResponseModel> searchShifts({
    String? facility,
    double? lat,
    double? lng,
    String? profession,
    double? minRange,
    String? shiftType,
    String? fromDate,
    String? toDate,
  }) async {
    if (lat == null ||
        lng == null ||
        minRange == null ||
        fromDate == null ||
        toDate == null ||
        shiftType == null ||
        profession == null) {
      isFilteredResult = true;
    }
    next = null;
    previous = null;
    _isLoading = true;
    notifyListeners();
    NetworkResponseModel responseModel = await ApiService.get(
      UrlList.shifts,
      queryParameters: {
        'search': facility,
        'latitude': lat?.toStringAsFixed(6),
        'longitude': lng?.toStringAsFixed(6),
        'profession': profession,
        'pay_min': minRange,
        'shift_type': shiftType,
        'from_date': fromDate,
        'to_date': toDate,
      },
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
    return responseModel;
  }
}
