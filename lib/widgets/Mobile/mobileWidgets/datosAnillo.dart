import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/model/Anillo.dart';

final urlDev = '${kIsWeb ? "localhost" : "10.0.2.2"}';

List<Anillo> storeListAnillos(String arrayAnillos) {
  final List<Anillo> listaAnillos = [];
  for (var anillo in jsonDecode(arrayAnillos)) {
    final anilloParsed = Anillo.fromJson(anillo);
    listaAnillos.add(anilloParsed);
  }
  return listaAnillos;
}

Future<Anillo> getAnillo(int id) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:4000/api/anillos/getone'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'id': id,
    }),
  );

  if (response.statusCode == 200) {
    return Anillo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load anillo');
  }
}

Future<List<Anillo>?> getAnillos() async {
  final response = await http.get(
    Uri.parse('http://$urlDev:4000/api/anillos'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return storeListAnillos(response.body);
  } else {
    throw Exception('Failed to load anillos');
  }
}

class DatosAnillo extends StatefulWidget {
  final Anillo anillo;
  const DatosAnillo({super.key, required this.anillo});

  @override
  State<DatosAnillo> createState() => _DatosAnilloState();
}

class _DatosAnilloState extends State<DatosAnillo> {
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
            Expanded(child: Text("Nombre : ", style: textStyle)),
            Expanded(child: Text(widget.anillo.nombre, style: textStyle)),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text("Talla: ", style: textStyle)),
            Expanded(child: Text(widget.anillo.talla, style: textStyle)),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text("Peso oro: ", style: textStyle)),
            Expanded(
                child:
                    Text(widget.anillo.pesos![0]['pesoOro'], style: textStyle)),
          ],
        ),
        Row(
          children: [
            Expanded(child: Text("Referencia : ", style: textStyle)),
            Expanded(child: Text(widget.anillo.referencia, style: textStyle)),
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
            Expanded(child: Text(widget.anillo.categoria, style: textStyle)),
          ],
        )
      ],
    );
  }
}
