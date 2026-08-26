import 'package:flutter/material.dart';
import 'package:stellar_explorer/models/earth_watch_model.dart';
import 'package:stellar_explorer/services/api_services.dart';

class EarthWatchProvider extends ChangeNotifier {
  final ApiServices api = ApiServices();
  bool loading = false;
  String errorMessage = "";
  List <EarthWatchModel> earthWatchList = []; 

  Future <void> fetchEarthWatchData () async {
    if (earthWatchList.isNotEmpty) return;  
    showLoading(true);
    errorMessage = "";
    try {
      earthWatchList = await api.getEarthWatchData();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      showLoading(false);
    }
  }

  Future<void> refreshEarthWatchData() async {
    earthWatchList.clear();
    errorMessage = "";
    try {
      earthWatchList = await api.getEarthWatchData();
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