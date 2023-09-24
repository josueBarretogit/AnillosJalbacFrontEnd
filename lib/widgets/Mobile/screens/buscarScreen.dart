import 'package:anillos_jalbac_flutter/widgets/Mobile/mobileWidgets/cardSwiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
          children: [
            Searchbar(),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 1500,
                minWidth: 900,
                maxHeight: kIsWeb ? 1000 : 600,
                minHeight: 400,
              ),
              child: Container(
                width: widthsize,
                height: heigthsize,
                child: CardSwiper(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> listaFiltros = [
    'nombre',
    'peso',
    'medida',
    'referencia',
    'categoria'
  ];
  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 25, 5, 5),
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Theme(
              data: Theme.of(context).copyWith(cardColor: Colors.black),
              child: PopupMenuButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  offset: const Offset(0, 40),
                  itemBuilder: (BuildContext context) {
                    return listaFiltros
                        .map((String filtro) => PopupMenuItem(
                            child: Text(filtro,
                                style: const TextStyle(color: Colors.white))))
                        .toList();
                  }),
            ),
            SizedBox(
              width: widthsize / 1.7,
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  hintText: '#100',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
