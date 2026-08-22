import 'package:flutter/material.dart';
import 'package:stellar_explorer/models/apod_model.dart';
import 'package:stellar_explorer/services/api_services.dart';

class ApodProvider extends ChangeNotifier {
  final ApiServices api = ApiServices();
  bool loading = false;
  String errorMessage = "";
  ApodModel ? apodData;

  Future <void> fetchAPOD () async {
    showLoading(true);
    errorMessage = "";  // Clear Previous erors
    try {
      apodData = await api.getAPOD();
    } catch (e) { 
      errorMessage = e.toString();
    } finally {
      showLoading(false);
    }
  }

  Future <void> refreshAPOD() async {
    errorMessage = ""; 
    try {
      apodData = await api.getAPOD(); 
    } catch (e) { 
      errorMessage = e.toString();
    } finally {
      notifyListeners(); 
    }
  }

  void showLoading (bool value) {
    loading = value;
    notifyListeners();
  }

}