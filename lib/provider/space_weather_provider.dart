import 'package:flutter/material.dart';
import 'package:stellar_explorer/models/space_weather_model.dart';
import 'package:stellar_explorer/services/api_services.dart';

class SpaceWeatherProvider extends ChangeNotifier {
  final ApiServices api = ApiServices();
  bool loading = false;
  String errorMessage = "";
  List <SpaceWeatherModel> spaceWeather = [];

  Future <void> fetchSpaceWeatherData () async {
    if (spaceWeather.isNotEmpty) return;
    showLoading(true);
    errorMessage = "";
    try {
      spaceWeather = await api.getSpaceWeatherData();
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