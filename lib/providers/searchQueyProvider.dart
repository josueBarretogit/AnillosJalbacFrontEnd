import 'package:flutter/material.dart';

class SearchQueryProvider extends ChangeNotifier {
  SearchQueryProvider();
  String searchTerm = '';

  String get searchedQueried => searchTerm;

  void setSearchQuery(String search) {
    searchTerm = search;
    notifyListeners();
  }
}
