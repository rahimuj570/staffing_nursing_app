import 'package:flutter/material.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/network/api_service.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/app/services/notification_service.dart';
import 'package:staffing/features/auth_features/models/auth_user_response_model.dart';
import 'package:staffing/features/auth_features/models/nurse_profile_me_response_model.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isObscure = true;
  bool get isObscure => _isObscure;

  void toggleObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  AuthUserResponseModel? currentUser;
  NurseProfileMeResponseModel? nurseProfileMeResponseModel;
  bool isLoading = false;
  Future<NetworkResponseModel> login({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();
    NetworkResponseModel response = await ApiService.post(
      UrlList.loginProfile,
      data: {"email": email, "password": password},
    );
    if (response.isSuccess) {
      NotificationService.instance.sendToken(
        await NotificationService.instance.getToken(),
      );
      currentUser = AuthUserResponseModel.fromJson(
        response.responseData['data']['user'],
      );
    }
    isLoading = false;
    notifyListeners();
    return response;
  }

  Future<void> fetchMe() async {
    isLoading = true;
    notifyListeners();

    final List<NetworkResponseModel> responses = await Future.wait([
      ApiService.get(UrlList.authMe),
      ApiService.get(UrlList.nurseProfileMe),
    ]);

    NetworkResponseModel authResponse = responses[0];
    NetworkResponseModel nurseResponse = responses[1];
    if (authResponse.isSuccess) {
      currentUser = AuthUserResponseModel.fromJson(
        authResponse.responseData['data'],
      );
    }
    if (nurseResponse.isSuccess) {
      nurseProfileMeResponseModel = NurseProfileMeResponseModel.fromJson(
        nurseResponse.responseData['data'],
      );
    }
    isLoading = false;
    notifyListeners();
  }
}
