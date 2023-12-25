import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/model/solitario.dart';

import 'package:anillos_jalbac_flutter/constants.dart' as constants;

List<Solitario> storeListSolitarios(String arraySolitarios) {
  final List<Solitario> listaSolitarios = [];
  for (var solitario in jsonDecode(arraySolitarios)) {
    final solitarioParsed = Solitario.fromJson(solitario);
    listaSolitarios.add(solitarioParsed);
  }
  return listaSolitarios;
}

Future<Solitario> getSolitario(int id) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:4000/api/solitarios/getone'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'id': id,
    }),
  );
  if (response.statusCode == 200) {
    return Solitario.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load solitario');
  }
}

Future<List<Solitario>?> getSolitarios() async {
  final response = await http.get(
    Uri.parse('https://anillosjalbacapi.onrender.com/api/solitarios'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return storeListSolitarios(response.body);
  } else {
    throw Exception('Failed to load solitarios');
  }
}

class DatosSolitario extends StatefulWidget {
  final Solitario solitario;
  const DatosSolitario({super.key, required this.solitario});

  @override
  State<DatosSolitario> createState() => _DatosSolitarioState();
}

List<Solitario>? filtrarPorSolitario(
    List<Solitario>? listSolitarios, String searchTerm) {
  return listSolitarios!.where((Solitario anillo) {
    return anillo.pesoOro.toLowerCase() == searchTerm ||
        anillo.pesoPlata.toLowerCase() == searchTerm ||
        anillo.referencia.toLowerCase() == searchTerm ||
        anillo.formaPiedra.toLowerCase().contains(searchTerm) ||
        anillo.talla.toLowerCase().contains(searchTerm) ||
        anillo.tamanoPiedra.toLowerCase().contains(searchTerm);
  }).toList();
}

class _DatosSolitarioState extends State<DatosSolitario> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 20.0,
      children: rowinColumn(solitario: widget.solitario).datosJoya(),
    );
  }
}

class rowinColumn {
  const rowinColumn({
    required this.solitario,
  });

  final Solitario solitario;

  List<Widget> datosJoya() {
    return [
      Row(
        children: [
          const Expanded(child: Text("Talla: ")),
          Expanded(child: Text(solitario.talla)),
        ],
      ),
      Row(
        children: [
          const Expanded(child: Text("Tamaño piedra")),
          Expanded(child: Text(solitario.tamanoPiedra)),
        ],
      ),
      Row(
        children: [
          const Expanded(child: Text("Forma piedra: ")),
          Expanded(child: Text(solitario.formaPiedra)),
        ],
      ),
      Row(
        children: [
          const Expanded(child: Text("Referencia : ")),
          Expanded(child: Text(solitario.referencia)),
        ],
      ),
      Row(
        children: [
          const Expanded(child: Text("Peso oro: ")),
          Expanded(child: Text(solitario.pesoOro)),
        ],
      ),
      Row(
        children: [
          const Expanded(child: Text("Peso plata : ")),
          Expanded(child: Text(solitario.pesoPlata)),
        ],
      ),
    ];
  }
}
