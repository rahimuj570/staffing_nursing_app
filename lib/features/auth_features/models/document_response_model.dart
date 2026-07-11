//  {
//         "document_type": "ssn_card",
//         "file": "/media/nurse_documents/2026/07/downloadfile_1.pdf",
//         "uploaded_at": "2026-07-09T08:13:33.315009Z"
//       },

import 'package:staffing/app/constants/url_list.dart';

class DocumentResponseModel {
  String? documentType;
  String? file;
  String? uploadedAt;

  DocumentResponseModel({this.documentType, this.file, this.uploadedAt});

  DocumentResponseModel.fromJson(Map<String, dynamic> json) {
    documentType = json['document_type'];
    file = '${UrlList.baseUrl}${json['file']}';
    uploadedAt = json['uploaded_at'];
  }
}
