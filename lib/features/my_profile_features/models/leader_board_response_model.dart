//  {
//     "nurse_id": 0,
//     "name": "string",
//     "profile_picture": "string",
//     "nurse_type": "string",
//     "points": 0,
//     "tier_name": "string"
//   }

class LeaderBoardResponseModel {
  final int? nurseId;
  final String? name;
  final String? profilePicture;
  final String? nurseType;
  final int? points;
  final String? tierName;

  LeaderBoardResponseModel({
    this.nurseId,
    this.name,
    this.profilePicture,
    this.nurseType,
    this.points,
    this.tierName,
  });

  factory LeaderBoardResponseModel.fromJson(Map<String, dynamic> json) {
    return LeaderBoardResponseModel(
      nurseId: json['nurse_id'],
      name: json['name'],
      profilePicture: json['profile_picture'],
      nurseType: json['nurse_type'],
      points: json['points'],
      tierName: json['tier_name'],
    );
  }
}
