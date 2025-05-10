import 'package:flutter/material.dart';

class LiteralFigurativeScreen extends StatefulWidget {
  const LiteralFigurativeScreen({super.key});

  @override
  State<LiteralFigurativeScreen> createState() =>
      _LiteralFigurativeScreenState();
}

class _LiteralFigurativeScreenState extends State<LiteralFigurativeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [Text("This is the LiteralFigurativeScreen")]),
      ),
    );
  }
}
