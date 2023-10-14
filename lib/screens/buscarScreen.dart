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

  List<dynamic> startPagination(List<dynamic> datos) {
    cantPages = ((datos.length) / numItemsPerPage).ceil();
    if (numItemsPerPage > datos.length) {
      return datos;
    } else {
      return datos.sublist(0, numItemsPerPage);
    }
  }

  List<dynamic>? datos;

  void updatePagination(int page, List<dynamic>? data) {
    final from = (page - 1) * numItemsPerPage;
    final end = page * numItemsPerPage;
    final minimoItemsShown = end - data!.length;
    setState(() {
      cantPages = ((data.length) / numItemsPerPage).ceil();
      if (end > data.length) {
        datos = data.sublist(from, end - minimoItemsShown);
      } else {
        datos = data.sublist(from, end);
      }
      updatedPagination = true;
    });
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
                  String joya = joyaProvider.getJoya;
                  if (snapshot.hasData) {
                    final searchTerm =
                        Provider.of<SearchQueryProvider>(context);

                    datos = searchTerm.filterData(
                        searchTerm.searchedQueried, snapshot.data, joya);

                    datos = startPagination(datos as List<dynamic>);

                    return Wrap(
                      runSpacing: 30,
                      spacing: 30,
                      alignment: WrapAlignment.center,
                      children: [
                        const Searchbar(),
                        if (datos!.isEmpty)
                          const Text('No se encontro datos')
                        else
                          ...datos!
                              .map((joya) => CartaConInfo(
                                    urlImage: 'img/anilloNombre1.jpg',
                                    joya: joya,
                                  ))
                              .toList(),
                        PaginationComponent(
                          cantPages: cantPages,
                          onUpdatePagination: updatePagination,
                          datos: datos,
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
