// {
// "upcoming_shifts": 0,
// I/flutter ( 6164): │ 💡       "earnings_this_week": "0.00",
// I/flutter ( 6164): │ 💡       "is_compliant": true,
// I/flutter ( 6164): │ 💡       "completed_shifts": 0,
// I/flutter ( 6164): │ 💡       "shifts_completed_this_month": 0,
// I/flutter ( 6164): │ 💡       "total_hours_this_month": "0.00",
// I/flutter ( 6164): │ 💡       "earnings_this_month": "0.00"
//   }

class StatsResponseModel {
  int? upcomingShifts;
  double? earningsThisWeek;

  bool? isCompliant;
  int? completedShifts;
  int? shiftsCompletedThisMonth;
  double? totalHoursThisMonth;
  double? earningsThisMonth;

  StatsResponseModel({
    this.upcomingShifts,
    this.earningsThisWeek,
    this.isCompliant,
    this.completedShifts,
    this.shiftsCompletedThisMonth,
    this.totalHoursThisMonth,
    this.earningsThisMonth,
  });

  StatsResponseModel.fromJson(Map<String, dynamic> json) {
    upcomingShifts = json['upcoming_shifts'];
    earningsThisWeek = json['earnings_this_week'] is double
        ? json['earnings_this_week']
        : double.parse(json['earnings_this_week']);
    isCompliant = json['is_compliant'];
    completedShifts = json['completed_shifts'];
    shiftsCompletedThisMonth = json['shifts_completed_this_month'];
    totalHoursThisMonth = json['total_hours_this_month'] is double
        ? json['total_hours_this_month']
        : double.parse(json['total_hours_this_month']);
    earningsThisMonth = json['earnings_this_month'] is double
        ? json['earnings_this_month']
        : double.parse(json['earnings_this_month']);
  }
}
