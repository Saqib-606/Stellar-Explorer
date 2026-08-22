import 'package:flutter/material.dart';
import 'package:stellar_explorer/models/exoplanets_model.dart';
import 'package:stellar_explorer/services/api_services.dart';

class ExoplanetsProvider extends ChangeNotifier {
  final ApiServices api = ApiServices();
  bool loading = false;
  String errorMessage = "";
  List <ExoplanetsModel> exoPlanets = [];


  Future <void> fetchExoPlanetsData () async {
    if (exoPlanets.isNotEmpty) return;
    showLoading(true);
    errorMessage = "";
    try {
      exoPlanets = await api.getExoPlanetsData();
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