import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> listaFiltros = ['nombre', 'peso', 'medida', 'categoria'];
  String filtrandoPor = 'nombre';
  final searchQueryController = TextEditingController();
  String searchTerm = '';
  @override
  void initState() {
    super.initState();

    searchQueryController.addListener(_showSearchQuery);
  }

  @override
  void _showSearchQuery() {
    print('changed: ${searchQueryController.text}');
    setState(() {
      searchTerm = searchQueryController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 25, 5, 5),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 2,
                  child: Theme(
                    data:
                        Theme.of(context).copyWith(cardColor: Colors.grey[900]),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: PopupMenuButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          offset: const Offset(0, 40),
                          itemBuilder: (BuildContext context) {
                            return listaFiltros
                                .map(
                                  (String filtro) => PopupMenuItem(
                                    onTap: () {
                                      setState(() {
                                        filtrandoPor = filtro;
                                      });
                                    },
                                    child: Text(filtro,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                )
                                .toList();
                          }),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: searchQueryController,
                      decoration: InputDecoration(
                        hintText: '#100',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(searchTerm),
          ],
        ),
      ),
    );
  }
}
