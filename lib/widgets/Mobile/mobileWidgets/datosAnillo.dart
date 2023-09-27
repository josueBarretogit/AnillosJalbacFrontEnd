import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/model/Anillo.dart';

Future<Anillo> getAnillo(int? id) async {
  final response = await http.post(
    Uri.parse('localhost:4000/api/anillos/getone'),
    body: jsonEncode(<String, int?>{
      'id': id,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Anillo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load anillo');
  }
}

class DatosAnillo extends StatefulWidget {
  const DatosAnillo({
    super.key,
  });

  @override
  State<DatosAnillo> createState() => _DatosAnilloState();
}

class _DatosAnilloState extends State<DatosAnillo> {
  late Future<Anillo> futureAnillo;
  @override
  void initState() {
    super.initState();
    futureAnillo = getAnillo(17);
  }

  Widget build(BuildContext context) {
    final TextStyle textStyle = const TextStyle(fontSize: kIsWeb ? 30 : 20);
    return FutureBuilder<Anillo>(
      future: futureAnillo,
      builder: (context, snapshot) {
        return Column(
          children: [
            Row(
              children: [
                Text("Nombre : ", style: textStyle),
                Text(snapshot.data!.nombre, style: textStyle),
              ],
            ),
            Row(
              children: [
                Text("Peso : ", style: textStyle),
                Text(snapshot.data!.peso, style: textStyle),
              ],
            ),
            Row(
              children: [
                Text("Talla: ", style: textStyle),
                Text(snapshot.data!.talla, style: textStyle),
              ],
            ),
            Row(
              children: [
                Text("Referencia : ", style: textStyle),
                Text(snapshot.data!.referencia, style: textStyle),
              ],
            ),
            Row(
              children: [
                Text("Categoria: ", style: textStyle),
                Text(snapshot.data!.categoria, style: textStyle),
              ],
            )
          ],
        );
      },
    );
  }
}
