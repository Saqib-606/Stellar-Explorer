import 'package:flutter/material.dart';
import 'package:stellar_explorer/models/planets_model.dart';
import 'package:stellar_explorer/services/api_services.dart';

class PlanetsProvider extends ChangeNotifier {
  final ApiServices api = ApiServices();
  bool loading = false;
  String errorMessage = "";
  PlanetsModel? planetData;

  Future <void> fetchPlanetData (String id) async {
    showLoading(true);
    errorMessage = "";
    try {
      planetData = await api.getPlanetsData(id);
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