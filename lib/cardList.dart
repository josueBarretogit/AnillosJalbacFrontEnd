import 'package:anillos_jalbac_flutter/widgets/genericCard.dart';

const List<String> listTitles = [
  'Anillo de nombre',
  'Dijes',
  'Anillos de grado',
];
final List<GenericCard> listCards = listTitles.map((title) {
  return GenericCard(title);
}).toList();
