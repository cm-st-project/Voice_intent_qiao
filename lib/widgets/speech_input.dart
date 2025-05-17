import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechInput extends StatefulWidget {
  final TextEditingController textController;
  final VoidCallback onInputComplete;
  const SpeechInput({
    required this.textController,
    required this.onInputComplete,
  });

  @override
  State<SpeechInput> createState() => _SpeechInputState();
}

class _SpeechInputState extends State<SpeechInput> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _speechEnabled = false;
  String _lastWords = '';
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechEnabled = await _speech.initialize(
      onError: (error) => _handleError(error.errorMsg),
      onStatus: (status) => _handleStatus(status),
    );
    setState(() {});
  }

  void _handleError(String error) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: $error')));
    setState(() {
      _isListening = false;
    });
  }

  void _handleStatus(String status) {
    if (status == 'done' || status == 'notlistening') {
      setState(() {
        _isListening = false;
      });
      if (_lastWords.isNotEmpty) {
        widget.textController.text = _lastWords;
        widget.onInputComplete();
      }
    }
  }

  Future<void> _startListening() async {
    if (!_speechEnabled) {
      _handleError("Speech recognition not available.");
      return;
    }
    setState(() {
      widget.textController.clear();
      _lastWords = '';
      _isListening = true;
    });

    await _speech.listen(
      onResult: (result) {
        setState(() {
          _lastWords = result.recognizedWords;
          if (result.finalResult) {
            _isListening = false;
            widget.textController.text = _lastWords;
            widget.onInputComplete();
          }
        });
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      partialResults: true,
      cancelOnError: true,
      listenMode: stt.ListenMode.confirmation,
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.textController,
            maxLines: 6,
            decoration: InputDecoration(
              hintText:
                  _speechEnabled
                      ? "Type or tap the microphone button to speak..."
                      : 'Speech recognition is not available',
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed:
                  _speechEnabled
                      ? (_isListening ? _stopListening : _startListening)
                      : null,
              icon: Icon(_isListening ? Icons.stop : Icons.mic),
              color:
                  _isListening
                      ? Colors.red
                      : _speechEnabled
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).disabledColor,
            ),
            if (_isListening)
              Text(
                'Listening...',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
          ],
        ),
      ],
    );
  }
}
