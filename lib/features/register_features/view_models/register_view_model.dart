import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/network/api_service.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/app/services/auth_prefs_service.dart';

class RegisterViewModel extends ChangeNotifier {
  TextEditingController experienceTEC = TextEditingController();
  TextEditingController stateLicenseNumberTEC = TextEditingController();

  PlatformFile? socialSecurityCard;
  PlatformFile? nursingLicense;
  PlatformFile? physicalExamination;

  String nurseType = 'CNA';

  void changeNurseType(String value) {
    nurseType = value;
    notifyListeners();
  }

  bool isIntersetInHousingProgram = true;
  void changeIsIntersetInHousingProgram(bool value) {
    isIntersetInHousingProgram = value;
    notifyListeners();
  }

  bool isLoading = false;
  Future<NetworkResponseModel> registerNurseProfile() async {
    isLoading = true;
    notifyListeners();
    //     {
    //   "nurse_type": "CNA",
    //   "years_of_experience": 0,
    //   "license_number": "string",
    //   "ssn_card": "string",
    //   "nursing_license": "string",
    //   "physical_exam": "string"
    // }
    FormData formData = FormData.fromMap({
      "nurse_type": nurseType,
      "years_of_experience": experienceTEC.text,
      "license_number": stateLicenseNumberTEC.text,
      "ssn_card": await MultipartFile.fromFile(socialSecurityCard!.path!),
      "nursing_license": await MultipartFile.fromFile(nursingLicense!.path!),
      "physical_exam": await MultipartFile.fromFile(physicalExamination!.path!),
    });
    NetworkResponseModel response = await ApiService.post(
      UrlList.registerNurseProfile,

      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer ${await AuthPrefsService().getToken()}",
        },
      ),
    );
    isLoading = false;
    notifyListeners();
    return response;
  }
}
