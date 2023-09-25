import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CartaConInfo extends StatefulWidget {
  final String urlImage;
  final String? filtro;
  const CartaConInfo({super.key, required this.urlImage, this.filtro});

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
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
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
                          Text("Talla: ", style: textStyle),
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
        ));
  }
}
