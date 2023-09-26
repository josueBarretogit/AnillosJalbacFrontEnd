import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

final Map<String, dynamic> dijeData = {
  'Alto': '15mm',
  'Ancho': '30mm',
  'Peso': '5gr',
  'PesoPlata': '7gr',
  'Referencia': '#100',
  'Categoria': 'Virgen'
};

final TextStyle textStyle = const TextStyle(fontSize: kIsWeb ? 30 : 20);

final List<Widget> datosDije = [
  Row(
    children: [
      Text("Alto : ", style: textStyle),
      Text(dijeData['Alto'], style: textStyle),
    ],
  ),
  Row(
    children: [
      Text("Ancho: ", style: textStyle),
      Text(dijeData['Ancho'], style: textStyle),
    ],
  ),
  Row(
    children: [
      Text("Peso: ", style: textStyle),
      Text(dijeData['Peso'], style: textStyle),
    ],
  ),
  Row(
    children: [
      Text("Peso plata : ", style: textStyle),
      Text(dijeData['PesoPlata'], style: textStyle),
    ],
  ),
  Row(
    children: [
      Text("Referencia : ", style: textStyle),
      Text(dijeData['Referencia'], style: textStyle),
    ],
  ),
  Row(
    children: [
      Text("Categoria: ", style: textStyle),
      Text(dijeData['Categoria'], style: textStyle),
    ],
  )
];
