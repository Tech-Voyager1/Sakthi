import 'package:flutter/material.dart';
import 'package:sakthi/dataEntryPage.dart';
import 'package:sakthi/homePage.dart';
import 'package:sakthi/scanner.dart';
import 'package:sakthi/scannerPage.dart';
import 'package:sakthi/splashScreen.dart';

void main() {
  runApp(Sakthi());
}

class Sakthi extends StatefulWidget {
  const Sakthi({super.key});

  @override
  State<Sakthi> createState() => _SakthiState();
}

class _SakthiState extends State<Sakthi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'
          // primarySwatch: Colors.blue,
          ),
      home: Dataentrypage(),
    );
  }
}
