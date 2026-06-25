import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  TextEditingController nameTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController confirmPasswordTEC = TextEditingController();
  TextEditingController addtessTEC = TextEditingController();
  TextEditingController ssnTEC = TextEditingController();
  TextEditingController experienceTEC = TextEditingController();
  TextEditingController stateLicenseNumberTEC = TextEditingController();

  PlatformFile? socialSecurityCard;
  PlatformFile? nursingLicense;
  PlatformFile? physicalExamination;

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
}
