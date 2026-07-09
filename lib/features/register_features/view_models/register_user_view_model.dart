import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/network/api_service.dart';
import 'package:staffing/app/network/network_response_model.dart';

class RegisterUserViewModel extends ChangeNotifier {
  bool passwordObsecure = true;
  bool confirmPasswordObsecure = true;

  void changePasswordObsecure() {
    passwordObsecure = !passwordObsecure;
    notifyListeners();
  }

  void changeConfirmPasswordObsecure() {
    confirmPasswordObsecure = !confirmPasswordObsecure;
    notifyListeners();
  }

  // {
  //   "name": "string",
  //   "phone": "string",
  //   "email": "user@example.com",
  //   "password": "string",
  //   "password_confirm": "string",
  //   "address": "string",
  //   "ssn": "string",
  //   "profile_picture": "string"
  // }
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<NetworkResponseModel> registerUser({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirm,
    required String address,
    required String ssn,
    required File? profilePicture,
  }) async {
    _isLoading = true;
    notifyListeners();

    FormData formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'password_confirm': passwordConfirm,
      'address': address,
      'ssn': ssn,
      'profile_picture': await MultipartFile.fromFile(profilePicture!.path),
      'role': "nurse",
    });
    NetworkResponseModel response = await ApiService.post(
      UrlList.registerUser,
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );

    _isLoading = false;
    notifyListeners();
    return response;
  }

  Future<NetworkResponseModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    _isLoading = true;
    notifyListeners();
    NetworkResponseModel response = await ApiService.post(
      UrlList.registerUserOtp,
      data: {"email": email, "code": otp},
    );
    _isLoading = false;
    notifyListeners();
    return response;
  }

  int resendOtpTimer = 0;

  void startResendOtpTimer() async {
    resendOtpTimer = 60;
    notifyListeners();
    while (resendOtpTimer > 0) {
      await Future.delayed(const Duration(seconds: 1), () {
        if (resendOtpTimer > 0) {
          resendOtpTimer -= 1;
          notifyListeners();
        }
      });
    }
  }

  Future<NetworkResponseModel> resendOtp({required String email}) async {
    NetworkResponseModel response = await ApiService.post(
      UrlList.registerUserResendOtp,
      data: {"email": email, "purpose": "registration"},
    );
    startResendOtpTimer();

    return response;
  }
}
