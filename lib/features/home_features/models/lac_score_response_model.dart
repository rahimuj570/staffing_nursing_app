// {
//     "score": 0,
//     "reliability": 0,
//     "punctuality": 0,
//     "performance": 0
//   }

class LacScoreResponseModel {
  final int score;
  final double? reliability;
  final double? punctuality;
  final double? performance;

  LacScoreResponseModel({
    required this.score,
    required this.reliability,
    required this.punctuality,
    required this.performance,
  });

  factory LacScoreResponseModel.fromJson(Map<String, dynamic> json) {
    return LacScoreResponseModel(
      score: json['score'],
      reliability: json['reliability'],
      punctuality: json['punctuality'],
      performance: json['performance'],
    );
  }
}
