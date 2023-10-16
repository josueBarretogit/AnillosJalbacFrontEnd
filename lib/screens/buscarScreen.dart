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
  int numItemsPerPage = 3;
  int cantPages = 1;

  void startPagination(List<dynamic> data) {
    cantPages = ((data.length) / numItemsPerPage).ceil();
    if (numItemsPerPage > data.length) {
      datos = data;
    } else {
      datos = data.sublist(0, numItemsPerPage);
    }

    updatedPagination = true;
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
    });
  }

  List<dynamic>? filterData(
      String searchTerm, List<dynamic> data, String joya) {
    if (searchTerm.isEmpty) {
      setState(() {
        datosFiltrado = data;
      });
    }

    searchTerm = searchTerm.toLowerCase();

    if (joya == 'nombre') {
      setState(() {
        datosFiltrado = filtrarPorAnillo(data as List<Anillo>, searchTerm);
      });
    } else if (joya == 'solitario') {
      setState(() {
        datosFiltrado =
            filtrarPorSolitario(data as List<Solitario>, searchTerm);
      });
    } else {
      setState(() {
        datosFiltrado = filtrarPorDije(data as List<Dije>, searchTerm);
      });
    }
  }

  List<dynamic>? datosFiltrado;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final searchQueryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final JoyaProvider joyaProvider = Provider.of<JoyaProvider>(context);
    String hintText = joyaProvider.getJoya == 'nombre'
        ? 'Ej: Maria'
        : joyaProvider.getJoya == 'solitario'
            ? 'Ej: forma piedra cuadrada'
            : 'Ej: 5mm alto';

    final widthsize = MediaQuery.sizeOf(context).width;
    if (widthsize >= 710) {
      setState(() {
        numItemsPerPage = 4;
      });
    }

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
                    final searchProvider =
                        Provider.of<SearchQueryProvider>(context);

                    if (!updatedPagination) {
                      startPagination(snapshot.data);
                    }

                    return Wrap(
                      runSpacing: 30,
                      spacing: 30,
                      alignment: WrapAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 25, 5, 5),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Buscar'),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: SizedBox(
                                        height: 40,
                                        width: widthsize / 2,
                                        child: TextField(
                                          controller: searchQueryController,
                                          onChanged: (String text) {
                                            searchProvider.setSearchQuery(text);
                                            filterData(
                                                text, snapshot.data, joya);
                                            updatePagination(1, datosFiltrado);
                                            searchProvider.setPageSelected(1);
                                          },
                                          decoration: InputDecoration(
                                            hintText: hintText,
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
                            key: Key(searchProvider.searchedQueried),
                            cantPages: cantPages,
                            onUpdatePagination: updatePagination,
                            datos: datosFiltrado ?? snapshot.data),
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
