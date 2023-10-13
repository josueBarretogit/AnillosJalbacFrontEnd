import 'package:anillos_jalbac_flutter/model/Anillo.dart';
import 'package:anillos_jalbac_flutter/model/dije.dart';
import 'package:anillos_jalbac_flutter/model/solitario.dart';
import 'package:anillos_jalbac_flutter/providers/joyaProvider.dart';
import 'package:anillos_jalbac_flutter/providers/searchQueyProvider.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/cartaConInfo.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/datosDije.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/datosSolitario.dart';
import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/searchBar.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/datosAnillo.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/paginationWidget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BuscarScreen extends StatefulWidget {
  final String appBarTitle;
  const BuscarScreen({
    super.key,
    required this.appBarTitle,
  });

  @override
  State<BuscarScreen> createState() => _BuscarScreenState();
}

class _BuscarScreenState extends State<BuscarScreen> {
  bool isRefreshed = false;

  late Future<dynamic> futureJoyas;

  bool updatedPagination = false;
  final numItemsPerPage = 3;
  int cantPages = 1;

  List<dynamic> datosCopy = [];

  void updatePagination(int page, List<dynamic>? datos) {
    final from = (page - 1) * numItemsPerPage;
    final end = page * numItemsPerPage;
    final minimoItemsShown = end - datos!.length;
    setState(() {
      cantPages = ((datos.length) / numItemsPerPage).ceil();
      if (end > datos.length) {
        datosCopy = datos.sublist(from, end - minimoItemsShown);
      } else {
        datosCopy = datos.sublist(from, end);
      }
      updatedPagination = true;
    });
  }

  void startPagination(List<dynamic> datos) {
    cantPages = ((datos.length) / numItemsPerPage).ceil();
    if (numItemsPerPage > datos.length) {
      datosCopy = datos;
    } else {
      datosCopy = datos.sublist(0, numItemsPerPage);
    }
  }

  void filterData(String searchTerm, List<dynamic> data, String joya) {
    searchTerm = searchTerm.toLowerCase();
    if (joya == 'nombre') {
      cantPages = ((data.length) / numItemsPerPage).ceil();
      datosCopy =
          filtrarPorAnillo(data as List<Anillo>, searchTerm) as List<Anillo>;

      cantPages = ((datosCopy.length) / numItemsPerPage).ceil();
    } else if (joya == 'solitario') {
      datosCopy = filtrarPorSolitario(data as List<Solitario>, searchTerm)
          as List<Solitario>;
    } else {
      datosCopy = filtrarPorDije(data as List<Dije>, searchTerm) as List<Dije>;
    }
  }

  @override
  Widget build(BuildContext context) {
    final JoyaProvider joyaProvider = Provider.of<JoyaProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(widget.appBarTitle),
        ),
        body: RefreshIndicator(
          strokeWidth: 4.0,
          onRefresh: () async {
            return Future<void>.delayed(const Duration(seconds: 3), () {
              setState(() {
                isRefreshed = true;
              });
            });
          },
          child: ChangeNotifierProvider<SearchQueryProvider>(
            create: (context) => SearchQueryProvider(),
            child: SingleChildScrollView(
              child: FutureBuilder<dynamic>(
                future: joyaProvider.getJoya == 'nombre'
                    ? getAnillos()
                    : joyaProvider.getJoya == 'solitario'
                        ? getSolitarios()
                        : getDijes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final searchTerm = Provider.of<SearchQueryProvider>(context)
                        .searchedQueried;

                    String joya = joyaProvider.getJoya;

                    if (!updatedPagination) {
                      startPagination(snapshot.data);
                    }

                    return Wrap(
                      runSpacing: 30,
                      spacing: 30,
                      alignment: WrapAlignment.center,
                      children: [
                        const Searchbar(),
                        if (snapshot.data.isEmpty)
                          const Text('No se encontro datos')
                        else
                          ...datosCopy
                              .map((joya) => CartaConInfo(
                                    urlImage: 'img/anilloNombre1.jpg',
                                    joya: joya,
                                  ))
                              .toList(),
                        PaginationComponent(
                          cantPages: cantPages,
                          onUpdatePagination: updatePagination,
                          datos: snapshot.data,
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Wrap(
                    runSpacing: 30,
                    spacing: 30,
                    alignment: WrapAlignment.center,
                    children: [
                      const Searchbar(),
                      LoadingAnimationWidget.discreteCircle(
                        color: Colors.white,
                        size: 100,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
