import 'package:flutter/foundation.dart';
import 'package:anillos_jalbac_flutter/screens/widgets/cartaSeleccion.dart';

const List<String> listTitles = [
  'Anillo de nombre',
  'Dijes',
  'Solitarios',
];

final urlDev = '${kIsWeb ? "localhost" : "10.0.2.2"}';

final List<CartaSeleccion> listCards = listTitles.map((title) {
  return CartaSeleccion(title);
}).toList();
