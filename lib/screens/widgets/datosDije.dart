import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/model/dije.dart';

final urlDev = '${kIsWeb ? "localhost" : "10.0.2.2"}';

List<Dije> storeListDijes(String arrayDijes) {
  final List<Dije> listaDijes = [];
  for (var dije in jsonDecode(arrayDijes)) {
    final dijeParsed = Dije.fromJson(dije);
    listaDijes.add(dijeParsed);
  }
  return listaDijes;
}

Future<List<Dije>?> getDijes() async {
  final response = await http.get(
    Uri.parse('http://$urlDev:4000/api/dijes'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return storeListDijes(response.body);
  } else {
    throw Exception('Failed to load anillos');
  }
}

List<Dije>? filtrarPorDije(List<Dije>? listDijes, String searchTerm) {
  return listDijes!.where((Dije anillo) {
    return anillo.pesoOro.toLowerCase() == searchTerm ||
        anillo.pesoPlata.toLowerCase() == searchTerm ||
        anillo.referencia.toLowerCase() == searchTerm ||
        anillo.alto.toLowerCase().contains(searchTerm) ||
        anillo.ancho.toLowerCase().contains(searchTerm) ||
        anillo.categoria.toLowerCase().contains(searchTerm);
  }).toList();
}

class DatosDije extends StatefulWidget {
  final Dije dije;
  const DatosDije({super.key, required this.dije});

  @override
  State<DatosDije> createState() => _DatosDijeState();
}

class _DatosDijeState extends State<DatosDije> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(child: Text("Altura : ")),
            Expanded(child: Text(widget.dije.alto)),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text("Anchura: ")),
            Expanded(child: Text(widget.dije.ancho)),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text("Referencia : ")),
            Expanded(child: Text(widget.dije.referencia)),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text("Peso oro : ")),
            Expanded(child: Text(widget.dije.pesoOro)),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text("Peso plata : ")),
            Expanded(child: Text(widget.dije.pesoPlata)),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text("Categoria: "),
            ),
            Expanded(child: Text(widget.dije.categoria)),
          ],
        )
      ],
    );
  }
}
