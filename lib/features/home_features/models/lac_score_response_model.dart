// {
//     "score": 0,
//     "reliability": 0,
//     "punctuality": 0,
//     "tier": 0
//   }

class LacScoreResponseModel {
  final int score;
  final double? reliability;
  final double? punctuality;
  final String? tier;

  LacScoreResponseModel({
    required this.score,
    required this.reliability,
    required this.punctuality,
    required this.tier,
  });

  factory LacScoreResponseModel.fromJson(Map<String, dynamic> json) {
    return LacScoreResponseModel(
      score: json['score'],
      reliability: json['reliability'],
      punctuality: json['punctuality'],
      tier: json['tier'],
    );
  }
}
