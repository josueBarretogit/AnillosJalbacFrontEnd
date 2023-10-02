import 'package:anillos_jalbac_flutter/screens/widgets/cardSwiper.dart';
import 'package:anillos_jalbac_flutter/providers/searchQueyProvider.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/cartaConInfo.dart';
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
    futureJoyas = getAnillos();
  }

  @override
  Widget build(BuildContext context) {
    final heigthsize = MediaQuery.sizeOf(context).height;
    final widthsize = MediaQuery.sizeOf(context).width;
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
                  final List<dynamic> datos = snapshot.data as List<dynamic>;
                  return Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Searchbar(),
                      for (var joya in datos)
                        CartaConInfo(
                          urlImage: 'img/anilloNombre1.jpg',
                          joya: joya,
                          joyaABuscar: widget.joyaABuscar,
                        ),
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

// ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxWidth: 1500,
//                     minWidth: 900,
//                     maxHeight: kIsWeb ? 1000 : 700,
//                     minHeight: 400,
//                   ),
//                   child: Container(
//                     width: widthsize,
//                     height: heigthsize,
//                     child: CardSwiper(
//                       filtro: 'nombre',
//                       joyaABuscar: widget.joyaABuscar,
//                       isRefresh: isRefreshed,
//                     ),
//                   ),
//                 ),
