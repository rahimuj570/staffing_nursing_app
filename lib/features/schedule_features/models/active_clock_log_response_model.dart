// "id":0,
//             "clock_in_at":"2026-07-13T06:01:38.858Z",
//             "clock_in_latitude":"-",
//             "clock_in_longitude":"-1",
//             "clock_out_at":"2026-07-13T06:01:38.858Z",
//             "clock_out_latitude":"55",
//             "clock_out_longitude":"3",
//             "hours_worked":0

class ActiveClockLogResponseModel {
  final int? id;
  final String? clockInAt;
  final String? clockInLatitude;
  final String? clockInLongitude;
  final String? clockOutAt;
  final String? clockOutLatitude;
  final String? clockOutLongitude;
  final int? hoursWorked;

  ActiveClockLogResponseModel({
    this.id,
    this.clockInAt,
    this.clockInLatitude,
    this.clockInLongitude,
    this.clockOutAt,
    this.clockOutLatitude,
    this.clockOutLongitude,
    this.hoursWorked,
  });

  factory ActiveClockLogResponseModel.fromJson(Map<String, dynamic> json) {
    return ActiveClockLogResponseModel(
      id: json['id'],
      clockInAt: json['clock_in_at'],
      clockInLatitude: json['clock_in_latitude'],
      clockInLongitude: json['clock_in_longitude'],
      clockOutAt: json['clock_out_at'],
      clockOutLatitude: json['clock_out_latitude'],
      clockOutLongitude: json['clock_out_longitude'],
      hoursWorked: json['hours_worked'],
    );
  }
}
