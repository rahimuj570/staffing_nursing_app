// {
//          "id":0,
//          "shift":{
//             "id":0,
//             "facility":{
//                "id":0,
//                "name":"string",
//                "image":"string",
//                "address":"string",
//                "city":"string",
//                "state":"string",
//                "latitude":"-.297996",
//                "longitude":"-9.76115"
//             },
//             "profession":"CNA",
//             "department":"string",
//             "shift_date":"2026-07-13",
//             "start_time":"06:01:38.858Z",
//             "end_time":"06:01:38.858Z",
//             "shift_type":"days",
//             "pay_rate":"6",
//             "pay_frequency":"daily",
//             "estimated_pay":0,
//             "openings_left":0,
//             "distance_km":0,
//             "status":"OPEN",
//             "required_nurses":2147483647,
//             "assignment_type":"staff_nurse",
//             "patient_ratio":"string",
//             "mandatory_float":true,
//             "experience_required_years":32767,
//             "dress_code":"string",
//             "notes":"string",
//             "created_at":"2026-07-13T06:01:38.858Z"
//          },
//          "status":"PENDING",
//          "assigned_at":"2026-07-13T06:01:38.858Z",
//          "active_clock_log":{
//             "id":0,
//             "clock_in_at":"2026-07-13T06:01:38.858Z",
//             "clock_in_latitude":"-",
//             "clock_in_longitude":"-1",
//             "clock_out_at":"2026-07-13T06:01:38.858Z",
//             "clock_out_latitude":"55",
//             "clock_out_longitude":"3",
//             "hours_worked":0
//          }
//       }

import 'package:staffing/features/schedule_features/models/active_clock_log_response_model.dart';
import 'package:staffing/features/shift_features/models/shift_detail_response.dart';

class SceduleResponseModel {
  final int? id;
  final ShiftDetailResponse? shift;
  final String? status;
  final String? assignedAt;
  final ActiveClockLogResponseModel? activeClockLog;

  SceduleResponseModel({
    required this.id,
    required this.shift,
    required this.status,
    required this.assignedAt,
    required this.activeClockLog,
  });

  factory SceduleResponseModel.fromJson(Map<String, dynamic> json) =>
      SceduleResponseModel(
        id: json['id'] as int?,
        shift: json['shift'] == null
            ? null
            : ShiftDetailResponse.fromJson(
                json['shift'] as Map<String, dynamic>,
              ),
        status: json['status'] as String?,
        assignedAt: json['assigned_at'] as String?,
        activeClockLog: json['active_clock_log'] == null
            ? null
            : ActiveClockLogResponseModel.fromJson(
                json['active_clock_log'] as Map<String, dynamic>,
              ),
      );
}
