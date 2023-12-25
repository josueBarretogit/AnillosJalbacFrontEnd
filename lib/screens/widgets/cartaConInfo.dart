import 'package:anillos_jalbac_flutter/providers/joyaProvider.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/datosAnillo.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/datosDije.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/datosSolitario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartaConInfo extends StatefulWidget {
  final String urlImage;
  final String? filtro;
  final dynamic joya;
  const CartaConInfo(
      {super.key, required this.urlImage, this.filtro, required this.joya});

  @override
  State<CartaConInfo> createState() => _CartaConInfoState();
}

class _CartaConInfoState extends State<CartaConInfo> {
  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;

    final JoyaProvider joyaProvider = Provider.of<JoyaProvider>(context);

    return Card(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 200,
              maxWidth: 350,
              maxHeight: 300,
            ),
            child: SizedBox(
              width: widthsize,
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  bottomLeft: widthsize >= 710
                      ? const Radius.circular(10)
                      : const Radius.circular(0),
                  topRight: widthsize <= 710
                      ? const Radius.circular(10)
                      : const Radius.circular(0),
                ),
                child: Image.network(
                  '${widget.joya.foto}',
                  fit: BoxFit.fill,
                  repeat: ImageRepeat.noRepeat,
                ),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 200,
              maxWidth: 350,
              minHeight: 300,
            ),
            child: SizedBox(
              width: widthsize,
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: joyaProvider.getJoya == 'nombre'
                      ? DatosAnillo(
                          anillo: widget.joya,
                        )
                      : joyaProvider.getJoya == 'solitario'
                          ? DatosSolitario(solitario: widget.joya)
                          : DatosDije(dije: widget.joya)),
            ),
          ),
        ],
      ),
    );
  }
}
