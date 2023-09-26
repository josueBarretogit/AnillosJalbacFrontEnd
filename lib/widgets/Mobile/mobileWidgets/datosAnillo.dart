import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/model/Anillo.dart';

Future<Anillo?> getAnillo(int? id) async {
  final response = await http.post(
    Uri.parse('localhost:4000/api/anillos/getone'),
    body: jsonEncode(<String, int?>{
      'id': id,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

var data;

Future<void> assignVariable() async {
  data = await getAnillo(17);
}

final TextStyle textStyle = const TextStyle(fontSize: kIsWeb ? 30 : 20);

final List<Widget> datosAnillo = [
  Row(
    children: [
      Text("Nombre : ", style: textStyle),
      Text(data['Nombre'], style: textStyle),
    ],
  ),
  Row(
    children: [
      Text("Peso : ", style: textStyle),
      Text(data['Peso'], style: textStyle),
    ],
  ),
  Row(
    children: [
      Text("Talla: ", style: textStyle),
      Text(data['Talla'], style: textStyle),
    ],
  ),
  Row(
    children: [
      Text("Referencia : ", style: textStyle),
      Text(data['Referencia'], style: textStyle),
    ],
  ),
  Row(
    children: [
      Text("Categoria: ", style: textStyle),
      Text(data['Categoria'], style: textStyle),
    ],
  )
];
