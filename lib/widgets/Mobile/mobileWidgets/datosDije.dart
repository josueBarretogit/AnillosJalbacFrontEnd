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

class DatosDije extends StatefulWidget {
  final Dije dije;
  const DatosDije({super.key, required this.dije});

  @override
  State<DatosDije> createState() => _DatosDijeState();
}

class _DatosDijeState extends State<DatosDije> {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = const TextStyle(
      fontSize: kIsWeb ? 30 : 20,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(child: Text("Altura : ", style: textStyle)),
            Expanded(child: Text(widget.dije.alto, style: textStyle)),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text("Anchura: ", style: textStyle)),
            Expanded(child: Text(widget.dije.ancho, style: textStyle)),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text("Peso oro: ", style: textStyle)),
            Expanded(
                child:
                    Text(widget.dije.pesos![0]['pesoOro'], style: textStyle)),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text("Referencia : ", style: textStyle)),
            Expanded(child: Text(widget.dije.referencia, style: textStyle)),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Categoria: ",
                style: textStyle,
                overflow: TextOverflow.clip,
              ),
            ),
            Expanded(child: Text(widget.dije.categoria, style: textStyle)),
          ],
        )
      ],
    );
  }
}
