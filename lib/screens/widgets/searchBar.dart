import 'package:anillos_jalbac_flutter/providers/searchQueyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SearchQueryProvider searchProvider =
        Provider.of<SearchQueryProvider>(context);

    final widthsize = MediaQuery.sizeOf(context).width;
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
                  child: SizedBox(
                    height: 40,
                    width: widthsize / 2,
                    child: TextField(
                      controller: searchQueryController,
                      onChanged: (String text) {
                        searchProvider.setSearchQuery(text);
                      },
                      decoration: InputDecoration(
                        hintText: 'Sofia',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
