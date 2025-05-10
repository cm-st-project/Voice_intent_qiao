import 'package:flutter/material.dart';

class EmotionsSpeechScreen extends StatefulWidget {
  const EmotionsSpeechScreen({super.key});

  @override
  State<EmotionsSpeechScreen> createState() => _EmotionsSpeechScreenState();
}

class _EmotionsSpeechScreenState extends State<EmotionsSpeechScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [Text("This is the EmotionSpeechScreen")]),
      ),
    );
  }
}
