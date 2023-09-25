import 'package:anillos_jalbac_flutter/cardList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:card_swiper/card_swiper.dart';

class CardSwiper extends StatefulWidget {
  const CardSwiper({Key? key}) : super(key: key);
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
        return CartaConInfo(urlImage: 'img/${index == 1 ? img1 : img2}');
      },
      itemCount: listCards.length,
      control: const SwiperControl(color: Colors.white),
    );
  }
}

class CartaConInfo extends StatefulWidget {
  final String urlImage;
  const CartaConInfo({super.key, required this.urlImage});

  @override
  State<CartaConInfo> createState() => _CartaConInfoState();
}

class _CartaConInfoState extends State<CartaConInfo> {
  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;
    final heigthsize = MediaQuery.of(context).size.height;
    final Map<String, dynamic> anilloData = {
      'Peso': '10gr',
      'Nombre': 'Josue',
      'Talla': '7',
      'Referencia': '#100',
      'Categoria': '3D'
    };
    final TextStyle textStyle = const TextStyle(fontSize: kIsWeb ? 30 : 20);
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: kIsWeb ? 600 : 300,
                  minHeight: 300,
                  maxHeight: kIsWeb ? 500 : 300,
                ),
                child: SizedBox(
                  width: widthsize,
                  height: heigthsize,
                  child: Image.asset(
                    widget.urlImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: kIsWeb ? 600 : 300,
                  minHeight: 300,
                  maxHeight: kIsWeb ? 500 : 300,
                ),
                child: Container(
                  color: Colors.grey[900],
                  width: widthsize,
                  height: heigthsize,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text("Nombre : ", style: textStyle),
                            Text(anilloData['Nombre'], style: textStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Peso : ", style: textStyle),
                            Text(anilloData['Peso'], style: textStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Talla :", style: textStyle),
                            Text(anilloData['Talla'], style: textStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Referencia : ", style: textStyle),
                            Text(anilloData['Referencia'], style: textStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Categoria: ", style: textStyle),
                            Text(anilloData['Categoria'], style: textStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
