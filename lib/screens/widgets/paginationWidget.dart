import 'package:flutter/material.dart';
import 'package:pagination_flutter/pagination.dart';

class PaginationComponent extends StatefulWidget {
  final int numPages;
  final Function? onUpdatePagination;
  const PaginationComponent(
      {super.key, required this.numPages, this.onUpdatePagination});

  @override
  State<PaginationComponent> createState() => _PaginationComponentState();
}

class _PaginationComponentState extends State<PaginationComponent> {
  int pageSelected = 1;
  @override
  Widget build(BuildContext context) {
    return Pagination(
      numOfPages: widget.numPages,
      selectedPage: pageSelected,
      pagesVisible: 3,
      onPageChanged: (int page) {
        setState(() {
          pageSelected = page;
        });
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
