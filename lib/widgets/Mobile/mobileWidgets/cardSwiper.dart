import 'package:anillos_jalbac_flutter/cardList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:card_swiper/card_swiper.dart';
import 'package:anillos_jalbac_flutter/widgets/Mobile/mobileWidgets/cartaConInfo.dart';

class CardSwiper extends StatefulWidget {
  final String? filtro;
  final String? joyaABuscar;
  const CardSwiper({Key? key, this.filtro, this.joyaABuscar}) : super(key: key);
  @override
  _CardSwiperState createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      onTap: (int index) => print('user tapped'),
      itemBuilder: (BuildContext context, int index) {
        const img1 = 'anilloNombre1.jpg';
        const img2 = 'anilloNombre2.jpg';
        return CartaConInfo(
          urlImage: 'img/${index == 1 ? img1 : img2}',
          filtro: widget.filtro,
          joyaABuscar: widget.joyaABuscar,
        );
      },
      itemCount: listCards.length,
      control: const SwiperControl(color: Colors.white),
      pagination: const SwiperPagination(),
    );
  }
}
