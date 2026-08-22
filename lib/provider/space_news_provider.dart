import 'package:flutter/material.dart';
import 'package:stellar_explorer/models/space_news_model.dart';
import 'package:stellar_explorer/services/api_services.dart';

class SpaceNewsProvider extends ChangeNotifier {
  final ApiServices api = ApiServices();
  bool loading = false;
  String errorMessage = "";
  List <SpaceNewsModel> spaceNews = [];

  Future <void> fetchSpaceNewsData () async {
    if (spaceNews.isNotEmpty) return;
    showLoading(true);
    errorMessage = "";
    try {
      spaceNews = await api.getSpaceNews();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      showLoading(false);
    }
  }

  Future <void> searchNewsData(String query) async {
    if (query.isEmpty) {
      spaceNews.clear();
      await fetchSpaceNewsData();
      return;
    }

    showLoading(true);
    errorMessage = "";

    try {
      spaceNews = await api.searchSpaceNews(query);
      if (spaceNews.isEmpty) {
        errorMessage = "No news found for '$query'";
      }
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