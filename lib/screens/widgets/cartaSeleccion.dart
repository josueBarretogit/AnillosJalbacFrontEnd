import 'package:anillos_jalbac_flutter/providers/joyaProvider.dart';
import 'package:anillos_jalbac_flutter/screens/buscarScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartaSeleccion extends StatefulWidget {
  final String textToSearch;

  const CartaSeleccion(this.textToSearch, {super.key});

  @override
  State<CartaSeleccion> createState() => _CartaSeleccionState();
}

class _CartaSeleccionState extends State<CartaSeleccion> {
  @override
  Widget build(BuildContext context) {
    final JoyaProvider joyaProvider = Provider.of<JoyaProvider>(context);
    return SizedBox(
      width: 300,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: CircleAvatar(
                  backgroundImage: AssetImage(widget.textToSearch
                          .toLowerCase()
                          .contains('nombre')
                      ? 'img/anilloNombre3.jpg'
                      : widget.textToSearch.toLowerCase().contains('solitario')
                          ? 'img/solitario.jpg'
                          : 'img/dije.jpg'),
                  radius: 100,
                ),
              ),
              Text(
                widget.textToSearch,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      final route = MaterialPageRoute(
                        builder: (context) => BuscarScreen(
                          appBarTitle: widget.textToSearch,
                        ),
                      );

                      if (widget.textToSearch.contains('nombre')) {
                        joyaProvider.setJoya('nombre');
                      } else if (widget.textToSearch
                          .toLowerCase()
                          .contains('solitario')) {
                        joyaProvider.setJoya('solitario');
                      } else {
                        joyaProvider.setJoya('dije');
                      }

                      Navigator.push(context, route);
                    },
                    child: Text(
                      'Buscar ${widget.textToSearch.trim().toLowerCase()}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
