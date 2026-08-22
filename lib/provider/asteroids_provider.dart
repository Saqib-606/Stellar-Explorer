import 'package:flutter/material.dart';
import 'package:stellar_explorer/models/asteroids_model.dart';
import 'package:stellar_explorer/services/api_services.dart';

class AsteroidsProvider extends ChangeNotifier {
  final ApiServices api = ApiServices();
  bool loading = false;
  String errorMessage = "";
  List <AsteroidsModel> asteroidsList = []; 

  Future <void> fetchAsteroidsData () async {
    if (asteroidsList.isNotEmpty) return;  // Don't fetch if data is already avaliable in list. Save Internet & API Limits
    showLoading(true);
    errorMessage = "";
    try {
      asteroidsList = await api.getAsteroidsData();
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