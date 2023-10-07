import 'package:anillos_jalbac_flutter/providers/joyaProvider.dart';
import 'package:flutter/material.dart';
import 'package:anillos_jalbac_flutter/MobileView.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<JoyaProvider>(
      create: (context) => JoyaProvider(),
      child: const MyApp(),
    ),
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
          child: MobileView(),
        ),
      ),
    );
  }
}
