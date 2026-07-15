// {
//     "terms_and_conditions": "Enim fugiat eos aper",
//     "privacy_policy": "Ut ipsam labore iure",
//     "about_us": "Excepteur sequi id c",
//     "contact_email": "cinefexyqa@mailinator.com",
//     "contact_phone": "+1 (353) 537-4117",
//     "contact_address": "Incidunt voluptas i",
//     "facebook": "https://www.lotuwitovoso.info",
//     "instagram": "https://www.tiqyjozy.us",
//     "twitter": "https://www.tuvofebove.org.au",
//     "linkedin": "https://www.pyp.com",
//     "youtube": "https://www.duzuzixebuzaj.co",
//     "updated_at": "2026-07-12T02:59:36.651813Z"
// "twkto_chat_link": "https://tawk.to/chat/6a5718aabc53df1d490a90ef/1jti3gn6o",
//   }

class MyProfileResponseModel {
  final String? termsAndConditions;
  final String? privacyPolicy;
  final String? aboutUs;
  final String? contactEmail;
  final String? contactPhone;
  final String? contactAddress;
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? linkedin;
  final String? youtube;
  final String? updatedAt;
  final String? twktoChatLink;

  MyProfileResponseModel({
    this.termsAndConditions,
    this.privacyPolicy,
    this.aboutUs,
    this.contactEmail,
    this.contactPhone,
    this.contactAddress,
    this.facebook,
    this.instagram,
    this.twitter,
    this.linkedin,
    this.youtube,
    this.updatedAt,
    this.twktoChatLink,
  });

  factory MyProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return MyProfileResponseModel(
      termsAndConditions: json['terms_and_conditions'],
      privacyPolicy: json['privacy_policy'],
      aboutUs: json['about_us'],
      contactEmail: json['contact_email'],
      contactPhone: json['contact_phone'],
      contactAddress: json['contact_address'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      twitter: json['twitter'],
      linkedin: json['linkedin'],
      youtube: json['youtube'],
      updatedAt: json['updated_at'],
      twktoChatLink: json['twkto_chat_link'],
    );
  }
}
