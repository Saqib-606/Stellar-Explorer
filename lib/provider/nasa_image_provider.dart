import 'package:flutter/material.dart';
import 'package:stellar_explorer/models/nasa_images_model.dart';
import 'package:stellar_explorer/services/api_services.dart';

class NasaImageProvider extends ChangeNotifier {
  final ApiServices api = ApiServices();
  bool loading = false;
  String errorMessage = "";
  List <NasaImagesModel> imageList = [];

  Future <void> fetchNasaImages (String query) async {
    showLoading(true);
    errorMessage = "";  // Clear Previous erors
    try {
      imageList = await api.getNASAImages(query);
    } catch (e) { 
      errorMessage = e.toString();
    } finally {
      showLoading(false);
    }
  }

  void clearImages() {
    imageList = [];
    notifyListeners(); 
  }

  void showLoading (bool value) {
    loading = value;
    notifyListeners();
  }

}