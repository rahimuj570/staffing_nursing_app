// {
//   "id": 2,
//   "title": "Shift Accepted",
//   "body": "Your shift request for Yetta Klein on 2026-07-22 was accepted.",
//   "data": {
//     "type": "shift_accepted",
//     "shift_id": "4"
//   },
//   "is_read": false,
//   "created_at": "2026-07-19T08:57:28.112951Z"
// },

import 'package:staffing/features/common_features/models/notification_type_response_model.dart';

class NotificationResponseModel {
  final int? id;
  final String? title;
  final String? body;
  final NotificationTypeResponseModel? data;
  bool? isRead;
  final String? createdAt;

  NotificationResponseModel({
    this.id,
    this.title,
    this.body,
    this.data,
    this.isRead,
    this.createdAt,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationResponseModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      data: json['data'] != null
          ? NotificationTypeResponseModel.fromJson(json['data'])
          : null,
      isRead: json['is_read'],
      createdAt: json['created_at'],
    );
  }
}
