import 'package:anillos_jalbac_flutter/widgets/Mobile/mobileWidgets/cardSwiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/widgets/Mobile/mobileWidgets/searchBar.dart';

class BuscarScreen extends StatefulWidget {
  final String appBarTitle;
  const BuscarScreen({super.key, required this.appBarTitle});

  @override
  State<BuscarScreen> createState() => _BuscarScreenState();
}

class _BuscarScreenState extends State<BuscarScreen> {
  @override
  Widget build(BuildContext context) {
    final heigthsize = MediaQuery.sizeOf(context).height;
    final widthsize = MediaQuery.sizeOf(context).width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(widget.appBarTitle),
      ),
      body: SingleChildScrollView(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
