import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/network/api_service.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/features/schedule_features/models/scedule_response_model.dart';

class ScheduleViewModel extends ChangeNotifier {
  int tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }

  List<String> status = ['Upcoming', 'Completed', 'Cancelled'];
  String getStatus() => status[tabIndex];

  ///////////////////CLOCK IN////////////////
  ///
  bool isClockIn = false;
  bool isClockChanging = false;
  Future<void> changeClockIn({required int id, required Position pos}) async {
    isClockChanging = true;
    notifyListeners();

    NetworkResponseModel response = await ApiService.post(
      UrlList.scheduleClockIn(id),
      data: {
        "latitude": pos.latitude.toStringAsFixed(6),
        "longitude": pos.longitude.toStringAsFixed(6),
      },
    );

    if (response.isSuccess) {
      isClockChanging = false;
    }
    isClockChanging = false;
    notifyListeners();
  }

  final List<String> _urls = [
    UrlList.sceduleUpcoming,
    UrlList.sceduleCompleted,
    UrlList.sceduleCancelled,
  ];

  ///////////////////CLOCK OUT/////////////////
  ///
  Future<void> changeClockOut({required int id, required Position pos}) async {
    isClockChanging = true;
    notifyListeners();
    NetworkResponseModel response = await ApiService.post(
      UrlList.scheduleClockOut(id),
      data: {
        "latitude": pos.latitude.toStringAsFixed(6),
        "longitude": pos.longitude.toStringAsFixed(6),
      },
    );
    if (response.isSuccess) {
      isClockIn = false;
    }
    isClockChanging = false;
    notifyListeners();
  }

  ///////////////////FETCH SCHEDULES////////////////////////////
  ///
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<SceduleResponseModel> schedules = [];
  String? next;
  String? previous;
  int totalPages = 1;
  int count = 0;
  Future<void> fetchSchedule() async {
    schedules = [];
    _isLoading = true;
    notifyListeners();
    NetworkResponseModel responseModel = await ApiService.get(_urls[tabIndex]);
    if (responseModel.isSuccess) {
      schedules = responseModel.responseData['data']
          .map<SceduleResponseModel>(
            (json) => SceduleResponseModel.fromJson(json),
          )
          .toList();
      next = responseModel.responseData['meta']['next'];
      previous = responseModel.responseData['meta']['previous'];
      totalPages = responseModel.responseData['meta']['total_pages'];
      count = responseModel.responseData['meta']['count'];
    }
    _isLoading = false;
    notifyListeners();
  }

  ////////////////////FETCH NEXT SCHEDULE////////////////////
  ///
  Future<void> fetchNextPage() async {
    schedules = [];
    _isLoading = true;
    notifyListeners();
    NetworkResponseModel responseModel = await ApiService.get(next!);
    if (responseModel.isSuccess) {
      schedules = responseModel.responseData['data']
          .map<SceduleResponseModel>(
            (json) => SceduleResponseModel.fromJson(json),
          )
          .toList();

      next = responseModel.responseData['meta']['next'];
      previous = responseModel.responseData['meta']['previous'];
      totalPages = responseModel.responseData['meta']['total_pages'];
    }
    _isLoading = false;
    notifyListeners();
  }

  ////////////////////Fetch PREVIOUS SCHEDULE ///////////////
  ///
  Future<void> fetchPreviousPage() async {
    schedules = [];
    _isLoading = true;
    notifyListeners();
    NetworkResponseModel responseModel = await ApiService.get(previous!);
    if (responseModel.isSuccess) {
      schedules = responseModel.responseData['data']
          .map<SceduleResponseModel>(
            (json) => SceduleResponseModel.fromJson(json),
          )
          .toList();
      next = responseModel.responseData['meta']['next'];
      previous = responseModel.responseData['meta']['previous'];
      totalPages = responseModel.responseData['meta']['total_pages'];
    }
    _isLoading = false;
    notifyListeners();
  }

  ///////////////////SCHEDULE CANCEL/////////////////
  ///
  Future<NetworkResponseModel> cancelSchedule({required int id}) async {
    _isLoading = true;
    notifyListeners();
    NetworkResponseModel responseModel = await ApiService.post(
      UrlList.scheduleCancel(id),
    );
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}
