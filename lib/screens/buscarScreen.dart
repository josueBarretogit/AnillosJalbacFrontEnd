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

  List<dynamic>? filterData(String searchTerm, List<dynamic>? data) {
    if (searchTerm.isEmpty) {
      return data;
    }
    searchTerm = searchTerm.toLowerCase();
    return data!.where((dynamic joya) {
      if (joya is Anillo) {
        return joya.nombre.toLowerCase().contains(searchTerm) ||
            joya.referencia.toLowerCase().contains(searchTerm) ||
            joya.categoria.toLowerCase().contains(searchTerm) ||
            joya.talla.toLowerCase().contains(searchTerm);
      } else if (joya is Dije) {
        return joya.alto.toLowerCase().contains(searchTerm) ||
            joya.ancho.toLowerCase().contains(searchTerm) ||
            joya.categoria.toLowerCase().contains(searchTerm) ||
            joya.referencia.toLowerCase().contains(searchTerm);
      } else if (joya is Solitario) {
        return joya.referencia.toLowerCase().contains(searchTerm) ||
            joya.tamanoPiedra.toLowerCase().contains(searchTerm) ||
            joya.formaPiedra.toLowerCase().contains(searchTerm) ||
            joya.talla.toLowerCase().contains(searchTerm) ||
            joya.referencia.toLowerCase().contains(searchTerm);
      }
      return false;
    }).toList();
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
                                  ))
                              .toList(),
                      ],
                    );
                  } else if (snapshot.hasError)
                    return Text('${snapshot.error}');
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
      ),
    );
  }
}
