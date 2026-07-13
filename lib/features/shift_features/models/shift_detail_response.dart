// {
//   "id": 0,
//   "facility": {
//     "id": 0,
//     "name": "string",
//     "image": "string",
//     "address": "string",
//     "city": "string",
//     "state": "string",
//     "latitude": "-853",
//     "longitude": "-06.1196"
//   },
//   "profession": "CNA",
//   "department": "string",
//   "shift_date": "2026-07-13",
//   "start_time": "02:49:56.446Z",
//   "end_time": "02:49:56.446Z",
//   "shift_type": "days",
//   "pay_rate": "-9117.01",
//   "pay_frequency": "daily",
//   "estimated_pay": 0,
//   "openings_left": 0,
//   "distance_km": 0,
//   "status": "OPEN",
//   "required_nurses": 2147483647,
//   "assignment_type": "staff_nurse",
//   "patient_ratio": "string",
//   "mandatory_float": true,
//   "experience_required_years": 32767,
//   "dress_code": "string",
//   "notes": "string",
//   "created_at": "2026-07-13T02:49:56.446Z"
// }

import 'package:staffing/features/shift_features/models/facility_response_model.dart';

class ShiftDetailResponse {
  final int? id;
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
  final int? distanceKm;
  final String? status;
  final int? requiredNurses;
  final String? assignmentType;
  final String? patientRatio;
  final bool? mandatoryFloat;
  final int? experienceRequiredYears;
  final String? dressCode;
  final String? notes;
  final String? createdAt;

  ShiftDetailResponse({
    required this.facility,
    required this.profession,
    required this.department,
    required this.shiftDate,
    required this.startTime,
    required this.endTime,
    required this.shiftType,
    required this.payRate,
    required this.payFrequency,
    required this.estimatedPay,
    required this.openingsLeft,
    required this.distanceKm,
    required this.status,
    required this.requiredNurses,
    required this.assignmentType,
    required this.patientRatio,
    required this.mandatoryFloat,
    required this.experienceRequiredYears,
    required this.dressCode,
    required this.notes,
    required this.createdAt,
    this.id,
  });

  factory ShiftDetailResponse.fromJson(Map<String, dynamic> json) {
    return ShiftDetailResponse(
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
      requiredNurses: json['required_nurses'],
      assignmentType: json['assignment_type'],
      patientRatio: json['patient_ratio'],
      mandatoryFloat: json['mandatory_float'],
      experienceRequiredYears: json['experience_required_years'],
      dressCode: json['dress_code'],
      notes: json['notes'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'facility': facility.toJson(),
    'profession': profession,
    'department': department,
    'shift_date': shiftDate,
    'start_time': startTime,
    'end_time': endTime,
    'shift_type': shiftType,
    'pay_rate': payRate,
    'pay_frequency': payFrequency,
    'estimated_pay': estimatedPay,
    'openings_left': openingsLeft,
    'distance_km': distanceKm,
    'status': status,
    'required_nurses': requiredNurses,
    'assignment_type': assignmentType,
    'patient_ratio': patientRatio,
    'mandatory_float': mandatoryFloat,
    'experience_required_years': experienceRequiredYears,
    'dress_code': dressCode,
    'notes': notes,
    'created_at': createdAt,
  };
}
