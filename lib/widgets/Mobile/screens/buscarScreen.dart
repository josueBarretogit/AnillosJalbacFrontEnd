import 'package:anillos_jalbac_flutter/widgets/Mobile/mobileWidgets/cardSwiper.dart';
import 'package:anillos_jalbac_flutter/providers/searchQueyProvider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/widgets/Mobile/mobileWidgets/searchBar.dart';
import 'package:provider/provider.dart';

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
  final prueba = Future<List<String>>.delayed(
      const Duration(seconds: 2), () => ['hola', 'adios']);

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
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Searchbar(),
                FutureBuilder<dynamic>(
                  future: prueba,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final Future<List<String>> datos = snapshot.data;
                      return Text(snapshot.data);
                    }
                    return CircularProgressIndicator();
                  },
                )
              ],
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
