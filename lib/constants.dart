import 'package:anillos_jalbac_flutter/screens/widgets/genericCard.dart';
import 'package:flutter/material.dart';

const List<String> listTitles = [
  'Anillo de nombre',
  'Dijes',
  'Solitarios',
];

final List<GenericCard> listCards = listTitles.map((title) {
  return GenericCard(title);
}).toList();

final TextStyle textStyle = const TextStyle(
  fontSize: 20,
);
