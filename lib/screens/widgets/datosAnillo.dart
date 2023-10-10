import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/model/Anillo.dart';
import 'package:anillos_jalbac_flutter/providers/searchQueyProvider.dart';
import 'package:anillos_jalbac_flutter/constants.dart';

final urlDev = '${kIsWeb ? "localhost" : "10.0.2.2"}';

List<Anillo> storeListAnillos(String arrayAnillos) {
  final List<Anillo> listaAnillos = [];
  for (var anillo in jsonDecode(arrayAnillos)) {
    final anilloParsed = Anillo.fromJson(anillo);
    listaAnillos.add(anilloParsed);
  }
  return listaAnillos;
}

Future<Anillo> getAnillo(int id) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:4000/api/anillos/getone'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'id': id,
    }),
  );

  if (response.statusCode == 200) {
    return Anillo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load anillo');
  }
}

Future<List<Anillo>?> getAnillos() async {
  final response = await http.get(
    Uri.parse('http://$urlDev:4000/api/anillos'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return storeListAnillos(response.body);
  } else {
    throw Exception('Failed to load anillos');
  }
}

class DatosAnillo extends StatefulWidget {
  final Anillo anillo;
  const DatosAnillo({super.key, required this.anillo});

  @override
  State<DatosAnillo> createState() => _DatosAnilloState();
}

class _DatosAnilloState extends State<DatosAnillo> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: Text("Nombre : ")),
              Expanded(child: Text(widget.anillo.nombre)),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("Talla: ")),
              Expanded(child: Text(widget.anillo.talla)),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("Peso oro: ")),
              Expanded(child: Text(widget.anillo.pesoOro)),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("Peso plata: ")),
              Expanded(child: Text(widget.anillo.pesoPlata)),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text("Referencia : ")),
              Expanded(child: Text(widget.anillo.referencia)),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text("Categoria: "),
              ),
              Expanded(child: Text(widget.anillo.categoria)),
            ],
          )
        ],
      ),
    );
  }
}
