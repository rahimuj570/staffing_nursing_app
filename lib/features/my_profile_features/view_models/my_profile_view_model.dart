import 'package:flutter/material.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/network/api_service.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/features/my_profile_features/models/my_profile_response_model.dart';

class MyProfileViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  MyProfileResponseModel? myProfileResponseModel;
  Future<void> fetchMyProfileContent() async {
    _isLoading = true;
    notifyListeners();
    NetworkResponseModel responseModel = await ApiService.get(UrlList.settings);

    if (responseModel.isSuccess) {
      myProfileResponseModel = MyProfileResponseModel.fromJson(
        responseModel.responseData['data'],
      );
    }

    _isLoading = false;
    notifyListeners();
  }
}
