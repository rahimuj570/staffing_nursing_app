import 'dart:io';

import 'package:dio/dio.dart';
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

  //////////////////////EDIT NURSE PROFILE/////////////
  ///
  Future<NetworkResponseModel> editNurseProfile({
    File? image,
    String? name,
    String? phone,
    String? address,
  }) async {
    _isLoading = true;
    notifyListeners();
    FormData formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'address': address,
    });
    if (image != null) {
      formData.files.add(
        MapEntry('profile_picture', await MultipartFile.fromFile(image.path)),
      );
    }
    NetworkResponseModel responseModel = await ApiService.patch(
      UrlList.profileUpdate,
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}
