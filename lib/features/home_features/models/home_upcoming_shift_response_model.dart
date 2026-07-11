// {
//     "id": 0,
//     "facility_name": "string",
//     "facility_city": "string",
//     "facility_state": "string",
//     "facility_image": "string",
//     "shift_date": "2026-07-11",
//     "start_time": "04:03:32.165Z",
//     "end_time": "04:03:32.165Z",
//     "profession": "string",
//     "assignment_status": "string"
//   }

class HomeUpcomingShiftResponseModel {
  int? id;
  String? facilityName;
  String? facilityCity;
  String? facilityState;
  String? facilityImage;
  String? shiftDate;
  String? startTime;
  String? endTime;
  String? profession;
  String? assignmentStatus;

  HomeUpcomingShiftResponseModel({
    this.id,
    this.facilityName,
    this.facilityCity,
    this.facilityState,
    this.facilityImage,
    this.shiftDate,
    this.startTime,
    this.endTime,
    this.profession,
    this.assignmentStatus,
  });

  HomeUpcomingShiftResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facilityName = json['facility_name'];
    facilityCity = json['facility_city'];
    facilityState = json['facility_state'];
    facilityImage = json['facility_image'];
    shiftDate = json['shift_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    profession = json['profession'];
    assignmentStatus = json['assignment_status'];
  }
}
