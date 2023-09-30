import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/widgets/Mobile/MobileView.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white, fontSize: 20),
        ),
        primaryColor: Colors.black,
        appBarTheme: AppBarTheme(color: Colors.grey[900], centerTitle: true),
        cardTheme: CardTheme(
          color: Colors.grey[900],
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Anillos Jalbac")),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints boxConstraints) {
              return MobileView();
            },
          ),
        ),
      ),
    );
  }
}
