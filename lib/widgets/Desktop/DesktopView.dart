import 'package:anillos_jalbac_flutter/widgets/genericCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({super.key});

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GenericCard('Nombres'),
        GenericCard('Dijes'),
      ],
    );
  }
}
