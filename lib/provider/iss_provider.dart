import 'package:flutter/material.dart';
import 'package:stellar_explorer/models/iss_model.dart';
import 'package:stellar_explorer/services/api_services.dart';

class IssProvider extends ChangeNotifier {
  final ApiServices api = ApiServices();
  bool loading = false;
  String errorMessage = "";
  IssModel ? issTracker;

  Future <void> getISSTrackerData () async {
    showLoading(true);
    errorMessage = "";  // Clear Previous erors
    try {
      issTracker = await api.trackISS();
    } catch (e) { 
      errorMessage = e.toString();
    } finally {
      showLoading(false);
    }
  }

  void showLoading (bool value) {
    loading = value;
    notifyListeners();
  }
}