import 'package:flutter/material.dart';
import 'package:stellar_explorer/models/launches_model.dart';
import 'package:stellar_explorer/services/api_services.dart';

class MissionProvider extends ChangeNotifier {
  final ApiServices api = ApiServices();
  bool loading = false;
  String errorMessage = "";
  List <LaunchesModel> missionData = [];

  Future <void> fetchMissionsData() async {
    if (missionData.isNotEmpty) return;
    showLoading(true);
    errorMessage = "";
    try {
      missionData = await api.getMissionsData();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      showLoading(false);
    }
  }

  Future <void> refreshMissionsData() async {
    missionData.clear();    
    await fetchMissionsData();
  }

  void showLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}