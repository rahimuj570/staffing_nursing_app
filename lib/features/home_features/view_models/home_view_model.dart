import 'package:flutter/material.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/network/api_service.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/features/home_features/models/home_dashboard_response_model.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  HomeDashboardResponseModel? homeDashboardResponseModel;

  Future<NetworkResponseModel> fetchHomeData() async {
    _isLoading = true;
    notifyListeners();

    NetworkResponseModel responseModel = await ApiService.get(UrlList.homeData);
    homeDashboardResponseModel = HomeDashboardResponseModel.fromJson(
      responseModel.responseData['data'],
    );

    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}
