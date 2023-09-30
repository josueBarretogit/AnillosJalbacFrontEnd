import 'package:flutter/material.dart';

class SearchQueryProvider extends ChangeNotifier {
  String? searchTerm = '';

  String? get searchedQueried => searchTerm;

  set setSearchQuery(String search) {
    searchTerm = search;
  }
}
