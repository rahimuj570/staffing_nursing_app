import 'package:flutter/material.dart';
import 'package:staffing/app/constants/url_list.dart';
import 'package:staffing/app/network/api_service.dart';
import 'package:staffing/app/network/network_response_model.dart';
import 'package:staffing/features/common_features/models/notification_response_model.dart';

class NotificationViewModel extends ChangeNotifier {
  String? next;
  bool isLoading = false;

  List<NotificationResponseModel> notifications = [];

  Future<void> fetchNotification() async {
    isLoading = true;
    notifyListeners();
    NetworkResponseModel responseModel = await ApiService.get(
      UrlList.notifications,
    );
    if (responseModel.isSuccess) {
      notifications = responseModel.responseData['data']
          .map<NotificationResponseModel>(
            (json) => NotificationResponseModel.fromJson(json),
          )
          .toList();
      next = responseModel.responseData['meta']['next'];
    }
    isLoading = false;
    notifyListeners();
  }

  bool isFetchingNextPage = false;
  Future<void> fetchNextPage() async {
    isFetchingNextPage = true;
    notifyListeners();
    NetworkResponseModel responseModel = await ApiService.get(next!);
    if (responseModel.isSuccess) {
      notifications.addAll(
        responseModel.responseData['data']
            .map<NotificationResponseModel>(
              (json) => NotificationResponseModel.fromJson(json),
            )
            .toList(),
      );
      next = responseModel.responseData['meta']['next'];
    }
    isFetchingNextPage = false;
    notifyListeners();
  }

  void locallyReadNotification(int id) {
    notifications.where((element) => element.id == id).first.isRead = true;
    notifyListeners();
  }

  void readNotification(int id) async {
    await ApiService.post(UrlList.readNotification(id));
    // if (responseModel.isSuccess) locallyReadNotification(id);
  }
}
