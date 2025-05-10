import 'package:flutter/material.dart';

class ScenariosScreen extends StatefulWidget {
  const ScenariosScreen({super.key});

  @override
  State<ScenariosScreen> createState() => _ScenariosScreenState();
}

class _ScenariosScreenState extends State<ScenariosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [Text("This is the ScenariosScreen")]),
      ),
    );
  }
}
