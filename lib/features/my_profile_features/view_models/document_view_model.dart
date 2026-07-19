import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/network/api_service.dart';
import 'package:staffing/app/network/network_response_model.dart';

class DocumentViewModel extends ChangeNotifier {
  bool isChanged = false;
  File? socialSecurityCard;
  File? nursingLicense;
  File? physicalExamination;

  bool isLoading = false;
  Future<NetworkResponseModel> updateDocument() async {
    isLoading = true;
    notifyListeners();

    final formData = FormData.fromMap({
      if (socialSecurityCard != null)
        'social_security_card': await MultipartFile.fromFile(
          socialSecurityCard!.path,
          filename: socialSecurityCard!.path.split('/').last,
        ),

      if (nursingLicense != null)
        'nursing_license': await MultipartFile.fromFile(
          nursingLicense!.path,
          filename: nursingLicense!.path.split('/').last,
        ),

      if (physicalExamination != null)
        'physical_examination': await MultipartFile.fromFile(
          physicalExamination!.path,
          filename: physicalExamination!.path.split('/').last,
        ),
    });

    NetworkResponseModel responseModel = await ApiService.patch(
      UrlList.profileUpdate,
      data: formData,
      // ❌ Do NOT set Content-Type manually
    );

    isLoading = false;
    notifyListeners();

    return responseModel;
  }

  void localSaveFile(File? file, String fileType) {
    if (fileType == 'ssn_card') socialSecurityCard = file;
    if (fileType == 'nursing_license') nursingLicense = file;
    if (fileType == 'physical_exam') physicalExamination = file;
    isChanged = true;
    notifyListeners();
  }

  void removeSingleFile(String fileType) {
    if (fileType == 'ssn_card') socialSecurityCard = null;
    if (fileType == 'nursing_license') nursingLicense = null;
    if (fileType == 'physical_exam') physicalExamination = null;
    isChanged =
        socialSecurityCard != null ||
        nursingLicense != null ||
        physicalExamination != null;
    notifyListeners();
  }

  bool isFileExist(String fileType) {
    if (fileType == 'ssn_card') return socialSecurityCard != null;
    if (fileType == 'nursing_license') return nursingLicense != null;
    if (fileType == 'physical_exam') return physicalExamination != null;
    return false;
  }

  File? getFile(String fileType) {
    if (fileType == 'ssn_card') return socialSecurityCard;
    if (fileType == 'nursing_license') return nursingLicense;
    if (fileType == 'physical_exam') return physicalExamination;
    return null;
  }

  void clearAll() {
    socialSecurityCard = null;
    nursingLicense = null;
    physicalExamination = null;
    isChanged = false;
    notifyListeners();
  }
}
