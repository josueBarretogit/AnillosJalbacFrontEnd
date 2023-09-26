import 'package:anillos_jalbac_flutter/widgets/Mobile/mobileWidgets/cardSwiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/widgets/Mobile/mobileWidgets/searchBar.dart';

class BuscarScreen extends StatefulWidget {
  final String appBarTitle;
  final String joyaABuscar;
  const BuscarScreen(
      {super.key, required this.appBarTitle, required this.joyaABuscar});

  @override
  State<BuscarScreen> createState() => _BuscarScreenState();
}

class _BuscarScreenState extends State<BuscarScreen> {
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
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Searchbar(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 1500,
                  minWidth: 900,
                  maxHeight: kIsWeb ? 1000 : 700,
                  minHeight: 400,
                ),
                child: Container(
                  width: widthsize,
                  height: heigthsize,
                  child: CardSwiper(
                    filtro: 'nombre',
                    joyaABuscar: widget.joyaABuscar,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
