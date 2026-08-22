import 'package:flutter/material.dart';
import 'package:stellar_explorer/models/launches_model.dart';
import 'package:stellar_explorer/services/api_services.dart';

class LaunchesProvider extends ChangeNotifier {
  final ApiServices api = ApiServices();
  bool loading = false;
  String errorMessage = "";
  List<LaunchesModel> launchesData = [];

  Future <void> fetchLaunchesData() async {
    if (launchesData.isNotEmpty) return;
    showLoading(true);
    errorMessage = "";
    try {
      launchesData = await api.getLaunchesData();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      showLoading(false);
    }
  }

  Future <void> refreshLaunchesData() async {
    launchesData.clear();    
    await fetchLaunchesData();
  }

  void showLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}