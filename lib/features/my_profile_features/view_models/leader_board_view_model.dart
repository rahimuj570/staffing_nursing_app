import 'package:flutter/material.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/network/api_service.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/features/my_profile_features/models/leader_board_response_model.dart';

class LeaderBoardViewModel extends ChangeNotifier {
  bool isLoading = false;

  List<LeaderBoardResponseModel> leaderBoardData = [];

  Future<void> fetchLeaderBoardData() async {
    isLoading = true;
    notifyListeners();
    NetworkResponseModel responseModel = await ApiService.get(
      UrlList.leaderBoard,
    );
    if (responseModel.isSuccess) {
      leaderBoardData = responseModel.responseData['data']
          .map<LeaderBoardResponseModel>(
            (json) => LeaderBoardResponseModel.fromJson(json),
          )
          .toList();
    }
    isLoading = false;
    notifyListeners();
  }
}
