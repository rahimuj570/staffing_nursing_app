// {
//   "lac_score": {
//     "score": 0,
//     "reliability": 0,
//     "punctuality": 0,
//     "performance": 0
//   },
//   "stats": {
//     "upcoming_shifts": 0,
//     "earnings_this_week": "406.",
//     "documents_expiring_soon": 0,
//     "is_compliant": true
//   },
//   "upcoming_shifts": [
//     {
//       "id": 0,
//       "facility_name": "string",
//       "facility_city": "string",
//       "facility_state": "string",
//       "facility_image": "string",
//       "shift_date": "2026-07-11",
//       "start_time": "04:15:34.096Z",
//       "end_time": "04:15:34.096Z",
//       "profession": "string",
//       "assignment_status": "string"
//     }
//   ]
// }

import 'package:staffing/features/home_features/models/home_upcoming_shift_response_model.dart';
import 'package:staffing/features/home_features/models/lac_score_response_model.dart';
import 'package:staffing/features/home_features/models/stats_response_model.dart';

class HomeDashboardResponseModel {
  final LacScoreResponseModel? lacScore;
  final StatsResponseModel? stats;
  final List<HomeUpcomingShiftResponseModel>? upcomingShifts;

  HomeDashboardResponseModel({this.lacScore, this.stats, this.upcomingShifts});

  factory HomeDashboardResponseModel.fromJson(Map<String, dynamic> json) {
    return HomeDashboardResponseModel(
      lacScore: json['lac_score'] != null
          ? LacScoreResponseModel.fromJson(json['lac_score'])
          : null,
      stats: json['stats'] != null
          ? StatsResponseModel.fromJson(json['stats'])
          : null,
      upcomingShifts: json['upcoming_shifts'] != null
          ? (json['upcoming_shifts'] as List)
                .map((e) => HomeUpcomingShiftResponseModel.fromJson(e))
                .toList()
          : null,
    );
  }
}
