import 'package:anillos_jalbac_flutter/cardList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MobileView extends StatefulWidget {
  const MobileView({super.key});

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.sizeOf(context).width;
    return ListView(
      children: [
        Wrap(
          spacing: 10.0,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.horizontal,
          children: listCards,
        ),
      ],
    );
  }
}
