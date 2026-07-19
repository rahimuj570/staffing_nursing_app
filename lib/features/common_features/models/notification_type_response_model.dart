//  {
//         "type": "shift_accepted",
//         "shift_id": "4"
//       },

class NotificationTypeResponseModel {
  String? type;
  String? shiftId;

  NotificationTypeResponseModel({this.type, this.shiftId});

  NotificationTypeResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    shiftId = json['shift_id'];
  }
}
