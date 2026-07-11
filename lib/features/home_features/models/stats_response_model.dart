// {
//     "upcoming_shifts": 0,
//     "earnings_this_week": ".5",
//     "documents_expiring_soon": 0,
//     "is_compliant": true
//   }

class StatsResponseModel {
  int? upcomingShifts;
  double? earningsThisWeek;
  int? documentsExpiringSoon;
  bool? isCompliant;

  StatsResponseModel({
    this.upcomingShifts,
    this.earningsThisWeek,
    this.documentsExpiringSoon,
    this.isCompliant,
  });

  StatsResponseModel.fromJson(Map<String, dynamic> json) {
    upcomingShifts = json['upcoming_shifts'];
    earningsThisWeek = json['earnings_this_week'] is double
        ? json['earnings_this_week']
        : double.parse(json['earnings_this_week']);
    documentsExpiringSoon = json['documents_expiring_soon'];
    isCompliant = json['is_compliant'];
  }
}
