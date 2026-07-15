// {
// "name": "string",
//   "phone": "string",
//   "profile_picture": "string",
//     "address": "qdwqd",
//     "nurse_type": "CNA",
//     "years_of_experience": 2,
//     "license_number": "2548fg",
//     "documents": [
//       {
//         "document_type": "ssn_card",
//         "file": "/media/nurse_documents/2026/07/downloadfile_1.pdf",
//         "uploaded_at": "2026-07-09T08:13:33.315009Z"
//       },
//       {
//         "document_type": "nursing_license",
//         "file": "/media/nurse_documents/2026/07/file-sample_150kB.pdf",
//         "uploaded_at": "2026-07-09T08:13:33.321410Z"
//       },
//       {
//         "document_type": "physical_exam",
//         "file": "/media/nurse_documents/2026/07/downloadfile.pdf",
//         "uploaded_at": "2026-07-09T08:13:33.328118Z"
//       }
//     ],
//     "application_status": "pending_review",
//     "submitted_at": "2026-07-09T08:13:33.306610Z"
//   }

import 'package:staffing/features/auth_features/models/document_response_model.dart';

class NurseProfileMeResponseModel {
  String? name;
  String? phone;
  String? profilePicture;
  String? address;
  String? nurseType;
  int? yearsOfExperience;
  String? licenseNumber;
  List<DocumentResponseModel>? documents;
  String? applicationStatus;
  String? submittedAt;

  NurseProfileMeResponseModel({
    this.name,
    this.phone,
    this.profilePicture,
    this.address,
    this.nurseType,
    this.yearsOfExperience,
    this.licenseNumber,
    this.documents,
    this.applicationStatus,
    this.submittedAt,
  });

  NurseProfileMeResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    profilePicture = json['profile_picture'];
    address = json['address'];
    nurseType = json['nurse_type'];
    yearsOfExperience = json['years_of_experience'];
    licenseNumber = json['license_number'];
    if (json['documents'] != null) {
      documents = <DocumentResponseModel>[];
      json['documents'].forEach((v) {
        documents!.add(DocumentResponseModel.fromJson(v));
      });
    }
    applicationStatus = json['application_status'];
    submittedAt = json['submitted_at'];
  }
}
