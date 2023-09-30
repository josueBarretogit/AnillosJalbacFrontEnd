import 'package:anillos_jalbac_flutter/cardList.dart';
import 'package:anillos_jalbac_flutter/widgets/Mobile/mobileWidgets/datosAnillo.dart';
import 'package:anillos_jalbac_flutter/widgets/Mobile/mobileWidgets/datosDije.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:anillos_jalbac_flutter/widgets/Mobile/mobileWidgets/cartaConInfo.dart';
import 'package:anillos_jalbac_flutter/model/Anillo.dart';
import 'package:anillos_jalbac_flutter/providers/searchQueyProvider.dart';
import 'package:provider/provider.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class CardSwiper extends StatefulWidget {
  final String? filtro;
  final String? joyaABuscar;
  final bool? isRefresh;
  const CardSwiper({Key? key, this.filtro, this.joyaABuscar, this.isRefresh})
      : super(key: key);
  @override
  _CardSwiperState createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  late Future<dynamic> futureAnillos;

  void refresh() async {
    Future<void>.delayed(const Duration(seconds: 2), () {
      setState(() {
        widget.joyaABuscar!.contains('nombre') ? getAnillos() : getDijes();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    futureAnillos =
        widget.joyaABuscar!.contains('nombre') ? getAnillos() : getDijes();
  }

  List<dynamic>? filterData(String searchTerm, List<dynamic>? data) {
    if (searchTerm.isEmpty) {
      return data;
    }
    return data!.where((dynamic joya) {
      return joya.nombre == searchTerm || joya.talla == searchTerm;
    }).toList();
  }

  Widget build(BuildContext context) {
    refresh();
    final searchProvider = Provider.of<SearchQueryProvider>(context);
    return FutureBuilder<dynamic>(
        future: futureAnillos,
        builder: (contex, snapshot) {
          if (snapshot.hasData) {
            final int? cantidadAnillos =
                filterData(searchProvider.searchedQueried, snapshot.data!)!
                    .length;

            return Swiper(
              itemBuilder: (BuildContext context, int index) {
                const img1 = 'anilloNombre1.jpg';
                const img2 = 'anilloNombre2.jpg';
                return CartaConInfo(
                  urlImage: 'img/${index == 1 ? img1 : img2}',
                  filtro: widget.filtro,
                  joyaABuscar: widget.joyaABuscar,
                  joya: snapshot.data![index],
                );
              },
              itemCount: cantidadAnillos ?? snapshot.data!.length,
              control: const SwiperControl(color: Colors.white),
              pagination: const SwiperPagination(),
            );
          } else if (snapshot.hasError) return Text('error ${snapshot.error}');
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: Colors.white,
              size: 100,
            ),
          );
        });
  }
}
