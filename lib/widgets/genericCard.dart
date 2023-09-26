import 'package:anillos_jalbac_flutter/widgets/Mobile/screens/buscarScreen.dart';
import 'package:flutter/material.dart';

class GenericCard extends StatefulWidget {
  final String textToSearch;

  const GenericCard(this.textToSearch, {super.key});

  @override
  State<GenericCard> createState() => _GenericCardState();
}

class _GenericCardState extends State<GenericCard> {
  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: AssetImage(
                      widget.textToSearch.contains('nombre')
                          ? 'img/anilloNombre3.jpg'
                          : 'img/anilloNombre2.jpg'),
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
                          joyaABuscar: widget.textToSearch.contains('nombre')
                              ? 'nombre'
                              : 'dije',
                          key: Key("1"),
                        ),
                      );
                      Navigator.push(context, route);
                    },
                    child: Text(
                        'Buscar ${widget.textToSearch.trim().toLowerCase()}'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
