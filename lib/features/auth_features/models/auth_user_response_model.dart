// I/flutter ( 4710): │ 💡       "name": "asda",
// I/flutter ( 4710): │ 💡       "email": "vicago9264@fisedo.com",
// I/flutter ( 4710): │ 💡       "phone": "sdasss",
// I/flutter ( 4710): │ 💡       "role": "nurse",
// I/flutter ( 4710): │ 💡       "profile_picture": "/media/profile_pictures/images_1_rwpnTIa.jpeg",
// I/flutter ( 4710): │ 💡       "is_active": true,
// I/flutter ( 4710): │ 💡       "onboarding_complete": true,
// I/flutter ( 4710): │ 💡       "date_joined": "2026-07-09T07:28:48.281435Z"
// I/flutter ( 4710): │ 💡     }
class AuthUserResponseModel {
  String? name;
  String? email;
  String? phone;
  String? role;
  String? profilePicture;
  bool? isActive;
  bool? onboardingComplete;
  String? dateJoined;

  AuthUserResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    profilePicture = json['profile_picture'];
    isActive = json['is_active'];
    onboardingComplete = json['onboarding_complete'];
    dateJoined = json['date_joined'];
  }
}
