import 'package:anillos_jalbac_flutter/widgets/genericCard.dart';

const List<String> listTitles = [
  'Anillo de nombre',
  'Dijes',
];
final List<GenericCard> listCards = listTitles.map((title) {
  return GenericCard(title);
}).toList();
