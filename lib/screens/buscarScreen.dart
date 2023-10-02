import 'package:anillos_jalbac_flutter/screens/widgets/cardSwiper.dart';
import 'package:anillos_jalbac_flutter/providers/searchQueyProvider.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/cartaConInfo.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/datosDije.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/searchBar.dart';
import 'package:provider/provider.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/datosAnillo.dart';

class BuscarScreen extends StatefulWidget {
  final String appBarTitle;
  final String joyaABuscar;
  const BuscarScreen(
      {super.key, required this.appBarTitle, required this.joyaABuscar});

  @override
  State<BuscarScreen> createState() => _BuscarScreenState();
}

class _BuscarScreenState extends State<BuscarScreen> {
  bool isRefreshed = false;

  late Future<dynamic> futureJoyas;

  @override
  void initState() {
    super.initState();
    futureJoyas =
        widget.joyaABuscar.contains('nombre') ? getAnillos() : getDijes();
  }

  List<dynamic>? filterData(String searchTerm, List<dynamic>? data) {
    if (searchTerm.isEmpty) {
      return data;
    }
    searchTerm = searchTerm.toLowerCase();

    return data!.where((dynamic joya) {
      return joya.nombre.toLowerCase() == searchTerm ||
          joya.talla.toLowerCase() == searchTerm ||
          joya.categoria.toLowerCase() == searchTerm ||
          joya.alto.toLowerCase() == searchTerm ||
          joya.ancho.toLowerCase() == searchTerm ||
          joya.referencia.toLowerCase() == searchTerm;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              future: futureJoyas,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final searchTerm =
                      Provider.of<SearchQueryProvider>(context).searchedQueried;
                  final List<dynamic> datos =
                      filterData(searchTerm, snapshot.data) as List<dynamic>;

                  return Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Searchbar(),
                      if (datos.isEmpty)
                        Text('No se encontro datos')
                      else
                        ...datos
                            .map((joya) => CartaConInfo(
                                  urlImage: 'img/anilloNombre1.jpg',
                                  joya: joya,
                                  joyaABuscar: widget.joyaABuscar,
                                ))
                            .toList(),
                    ],
                  );
                } else if (snapshot.hasError) return Text('${snapshot.error}');
                return Center(
                  child: LoadingAnimationWidget.discreteCircle(
                    color: Colors.white,
                    size: 100,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
