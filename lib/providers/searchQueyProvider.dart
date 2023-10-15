import 'package:anillos_jalbac_flutter/model/Anillo.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/datosAnillo.dart';
import 'package:flutter/material.dart';

class SearchQueryProvider extends ChangeNotifier {
  SearchQueryProvider();

  String searchTerm = '';
  String get searchedQueried => searchTerm;

  int pageSelected = 1;

  int get currentPageSelected => pageSelected;

  bool searchTermIsEmpty = false;
  bool get isSearchTermEmpty => searchTermIsEmpty;

  void setPageSelected(int page) {
    pageSelected = page;
    notifyListeners();
  }

  void setSearchQuery(String search) {
    searchTerm = search;
    notifyListeners();
  }

  void setSearchTermIsEmpty(bool search) {
    searchTermIsEmpty = search;
    notifyListeners();
  }

  List<dynamic>? filterData(
      String searchTerm, List<dynamic> data, String joya) {
    if (searchTerm.isEmpty) {
      return data;
    }

    searchTerm = searchTerm.toLowerCase();

    if (joya == 'nombre') {
      return filtrarPorAnillo(data as List<Anillo>, searchTerm);
    }
  }
}
