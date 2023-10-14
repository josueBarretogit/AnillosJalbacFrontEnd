import 'package:anillos_jalbac_flutter/model/Anillo.dart';
import 'package:anillos_jalbac_flutter/model/dije.dart';
import 'package:anillos_jalbac_flutter/model/solitario.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/datosAnillo.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/datosDije.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/datosSolitario.dart';
import 'package:flutter/material.dart';

class SearchQueryProvider extends ChangeNotifier {
  SearchQueryProvider();

  String searchTerm = '';
  String get searchedQueried => searchTerm;

  bool searchTermIsEmpty = false;
  bool get isSearchTermEmpty => searchTermIsEmpty;

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
      notifyListeners();
      return data;
    }

    searchTerm = searchTerm.toLowerCase();

    if (joya == 'nombre') {
      notifyListeners();
      return filtrarPorAnillo(data as List<Anillo>, searchTerm);
    }
  }
}
