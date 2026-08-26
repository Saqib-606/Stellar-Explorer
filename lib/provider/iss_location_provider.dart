import 'package:flutter/material.dart';
import 'package:stellar_explorer/models/iss_location_model.dart';
import 'package:stellar_explorer/services/api_services.dart';

class IssLocationProvider extends ChangeNotifier {
  final ApiServices api = ApiServices();
  bool loading = false;
  String errorMessage = "";
  IssLocationModel ? issLocation;

  Future <void> fetchISSLocation (double lat, double lon) async {
    showLoading(true);
    errorMessage = "";  
    try {
      issLocation = await api.getISSLocation(lat, lon);
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