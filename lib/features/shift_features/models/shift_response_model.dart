// {
//       "id": 1,
//       "facility": {
//         "id": 4,
//         "name": "Jarrod Stewart",
//         "image": null,
//         "address": "Ipsum do eiusmod expedita error",
//         "city": "Atque tempor magna a vel est perferendis sapiente",
//         "state": "Ipsa eiusmod sapiente quaerat dolores atque sit qui nulla occaecat",
//         "latitude": "74.000000",
//         "longitude": "64.000000"
//       },
//       "profession": "RN",
//       "department": "Ea et consequatur minus ad magni quidem natus minus enim fuga Accusantium omnis laboriosam perfere",
//       "shift_date": "2026-07-08",
//       "start_time": "05:55:10",
//       "end_time": "05:55:11",
//       "shift_type": "evenings",
//       "pay_rate": "14.00",
//       "pay_frequency": "daily",
//       "estimated_pay": 336,
//       "openings_left": 27,
//       "distance_km": null,
//       "status": "OPEN"
//     },

import 'package:staffing/features/shift_features/models/facility_response_model.dart';

class ShiftResponseModel {
  final int id;
  final FacilityResponseModel facility;
  final String? profession;
  final String? department;
  final String? shiftDate;
  final String? startTime;
  final String? endTime;
  final String? shiftType;
  final String? payRate;
  final String? payFrequency;
  final double? estimatedPay;
  final int? openingsLeft;
  final double? distanceKm;
  final String? status;

  ShiftResponseModel({
    required this.id,
    required this.facility,
    this.profession,
    this.department,
    this.shiftDate,
    this.startTime,
    this.endTime,
    this.shiftType,
    this.payRate,
    this.payFrequency,
    this.estimatedPay,
    this.openingsLeft,
    this.distanceKm,
    this.status,
  });

  factory ShiftResponseModel.fromJson(Map<String, dynamic> json) {
    return ShiftResponseModel(
      id: json['id'],
      facility: FacilityResponseModel.fromJson(json['facility']),
      profession: json['profession'],
      department: json['department'],
      shiftDate: json['shift_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      shiftType: json['shift_type'],
      payRate: json['pay_rate'],
      payFrequency: json['pay_frequency'],
      estimatedPay: json['estimated_pay'],
      openingsLeft: json['openings_left'],
      distanceKm: json['distance_km'],
      status: json['status'],
    );
  }
}
