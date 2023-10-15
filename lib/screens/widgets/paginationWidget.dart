import 'package:anillos_jalbac_flutter/providers/joyaProvider.dart';
import 'package:anillos_jalbac_flutter/providers/searchQueyProvider.dart';
import 'package:flutter/material.dart';
import 'package:pagination_flutter/pagination.dart';
import 'package:provider/provider.dart';

class PaginationComponent extends StatefulWidget {
  final int cantPages;
  final List<dynamic>? datos;
  final Function onUpdatePagination;
  const PaginationComponent(
      {super.key,
      required this.onUpdatePagination,
      required this.cantPages,
      required this.datos});

  @override
  State<PaginationComponent> createState() => _PaginationComponentState();
}

class _PaginationComponentState extends State<PaginationComponent> {
  @override
  Widget build(BuildContext context) {
    final SearchQueryProvider searchProvider =
        Provider.of<SearchQueryProvider>(context);

    return Pagination(
      numOfPages: widget.cantPages,
      selectedPage: searchProvider.currentPageSelected,
      pagesVisible: 3,
      onPageChanged: (int page) {
        setState(() {
          searchProvider.setPageSelected(page);
        });

        widget.onUpdatePagination(page, widget.datos);
      },
      nextIcon: Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 14,
      ),
      previousIcon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: 14,
      ),
      activeTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      activeBtnStyle: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey[900]),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(38),
          ),
        ),
      ),
      inactiveBtnStyle: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(38),
        )),
      ),
      inactiveTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
