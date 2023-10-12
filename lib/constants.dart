import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/cartaSeleccion.dart';

const List<String> listTitles = [
  'Anillo de nombre',
  'Dijes',
  'Solitarios',
];

final List<CartaSeleccion> listCards = listTitles.map((title) {
  return CartaSeleccion(title);
}).toList();
