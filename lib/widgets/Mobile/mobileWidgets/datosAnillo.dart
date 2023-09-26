import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

final Map<String, dynamic> anilloData = {
  'Peso': '10gr',
  'Nombre': 'Josue',
  'Talla': '7',
  'Referencia': '#100',
  'Categoria': '3D'
};

final TextStyle textStyle = const TextStyle(fontSize: kIsWeb ? 30 : 20);

final List<Widget> datosAnillo = [
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
  )
];
