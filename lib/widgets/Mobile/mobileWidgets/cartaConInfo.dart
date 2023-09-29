import 'package:anillos_jalbac_flutter/widgets/Mobile/mobileWidgets/datosAnillo.dart';
import 'package:anillos_jalbac_flutter/widgets/Mobile/mobileWidgets/datosDije.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:anillos_jalbac_flutter/model/Anillo.dart';

class CartaConInfo extends StatefulWidget {
  final String urlImage;
  final String? filtro;
  final String? joyaABuscar;
  final dynamic joya;
  const CartaConInfo(
      {super.key,
      required this.urlImage,
      this.filtro,
      this.joyaABuscar,
      required this.joya});

  @override
  State<CartaConInfo> createState() => _CartaConInfoState();
}

class _CartaConInfoState extends State<CartaConInfo> {
  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;
    final heigthsize = MediaQuery.of(context).size.height;

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
                  child: widget.joyaABuscar == 'nombre'
                      ? DatosAnillo(
                          anillo: widget.joya,
                        )
                      : DatosDije(dije: widget.joya),
                ),
              ),
            ),
          ],
        ));
  }
}
