import 'package:flutter/material.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/network/api_service.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/features/auth_features/models/auth_user_response_model.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isObscure = true;
  bool get isObscure => _isObscure;

  void toggleObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  AuthUserResponseModel? currentUser;
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
    NetworkResponseModel response = await ApiService.get(UrlList.authMe);
    if (response.isSuccess) {
      currentUser = AuthUserResponseModel.fromJson(
        response.responseData['data'],
      );
    }
    isLoading = false;
    notifyListeners();
  }
}
