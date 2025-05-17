import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'dart:io';
import '../services/emotion_service.dart';
import '../models/emotion_result.dart';
import 'dart:async';

class EmotionDetector extends StatefulWidget {
  final EmotionDetector emotionService;

  const EmotionDetector({required this.emotionService});

  @override
  State<EmotionDetector> createState() => _EmotionDetectorState();
}

class _EmotionDetectorState extends State<EmotionDetector> {
  final _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  EmotionResult? _lastResult;
  String? _recordingPath;
  double _amplitude = 0.0;
  bool _isPaused = false;
  Duration _recordingDuration = Duration.zero;
  Timer? _durationTimer;
  bool _isAnalyzing = false;

  @override
  void initState() {
    super.initState();
    _initializeRecorder(); //TODO
  }

  Future<void> _initializedRecorder() async {
    final hasPermission = await _audioRecorder.hasPermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Microphone permission not granted")),
      );
    }
  }

  void _startDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration += const Duration(seconds: 1);
      });
    });
  }

  void _stopDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = null;
    _recordingDuration = Duration.zero;
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final tempDir = Directory.systemTemp;
        _recordingPath = '${tempDir.path}/teno_recording.wav';
      }

      await _audioRecorder.start(
        RecordConfig(
          encoder: AudioEncoder.wav,
          bitRate: 128000,
          sampleRate: 44100,
          numChannels: 1,
        ),
        path: _recordingPath!,
      );

      setState(() {
        _isRecording = true;
        _isPaused = false;
        _lastResult = null;
      });

      _startDurationTimer();
      _startAmplitudeListener();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error Starting recording: $e")));
    }
  }

  Future<void> _pauseRecording() async {
    try {
      await _audioRecorder.pause();
      setState(() {
        _isPaused = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error Pausing recording: $e")));
    }
  }

  Future<void> _resumeRecording() async {
    try {
      await _audioRecorder.pause();
      setState(() {
        _isPaused = false;
      });
      _startAmplitudeListener();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error Resuming recording: $e")));
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _audioRecorder.stop();
      _stopDurationTimer();
      setState(() {
        _isRecording = false;
        _isPaused = true;
        _amplitude = 0.0;
        _isAnalyzing = true;
      });

      if (_recordingPath != null) {
        final file = File(_recordingPath!);
        if (await file.exists()) {
          final audioBytes = await file.readAsBytes();
          final result = await widget.emotionService.analyzeAudio(audioBytes);
          setState(() {
            _lastResult = result;
            _isAnalyzing = false;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error stopping recording: $e")));
    }
  }

  void _startAmplitudeListener() {
    Future.doWhile(() async {
      if (!_isRecording || _isPaused) {
        return false;
      }

      try {
        final amplitude = await _audioRecorder.getAmplitude();
        setState(() {
          _amplitude = amplitude.current;
        });
      } catch (e) {
        debugPrint("Error getting amplitude: $e");
      }

      await Future.delayed(const Duration(milliseconds: 100));
      return _isRecording && !_isPaused;
    });
  }

  @override
  void dispose() {
    _stopDurationTimer();
    _audioRecorder.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Map<String, Color> _getEmotionColor(BuildContext context) {
    return {
      // Positive emotions
      'Joy': Colors.yellow.shade600,
      'Happiness': Colors.yellow.shade600,
      'Excitement': Colors.orange.shade400,
      'Love': Colors.pink.shade400,
      'Satisfaction': Colors.green.shade400,
      'Pride': Colors.purple.shade400,
      'Triumph': Colors.purple.shade600,
      'Contentment': Colors.lightGreen,
      'Relief': Colors.lightBlue,
      'Amusement': Colors.amber,
      'Interest': Colors.teal,

      // Negative emotions
      'Anger': Colors.red.shade400,
      'Sadness': Colors.blue.shade700,
      'Fear': Colors.deepPurple.shade400,
      'Disgust': Colors.green.shade700,
      'Anxiety': Colors.orange.shade700,
      'Confusion': Colors.indigo.shade400,
      'Doubt': Colors.blueGrey.shade400,
      'Disappointment': Colors.brown.shade400,
      'Frustration': Colors.red.shade700,
      'Boredom': Colors.grey.shade600,

      // Neutral/Complex emotions
      'Surprise (positive)': Colors.amber.shade400,
      'Surprise (negative)': Colors.deepOrange.shade400,
      'Contemplation': Colors.blue.shade400,
      'Concentration': Colors.cyan.shade600,
      'Empathic Pain': Colors.purple.shade300,
      'Nostalgia': Colors.deepPurple.shade300,
      'Realization': Colors.lightBlue.shade700,
      'Awkwardness': Colors.pink.shade300,
      'Tiredness': Colors.grey.shade500,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AmplitudePainter extends CustomPainter {
  final double amplitude;
  final bool isRecording;
  final Color color;

  AmplitudePainter({
    required this.amplitude,
    required this.isRecording,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = isRecording ? color : color.withOpacity(0.3)
          ..style = PaintingStyle.fill;

    // Draw multiple bars for a more dynamic effect
    final barCount = 20;
    final barWidth = size.width / barCount;
    final spacing = barWidth * 0.2;
    final maxHeight = size.height * 0.8;

    for (var i = 0; i < barCount; i++) {
      final barHeight = maxHeight * (amplitude.clamp(0.0, 1.0));
      final x = i * barWidth;
      final y = size.height - barHeight;

      // Add some randomness to make it more dynamic
      final randomFactor = 0.2 + (i % 3) * 0.1;
      final adjustedHeight = barHeight * randomFactor;

      final rect = Rect.fromLTWH(
        x + spacing,
        size.height - adjustedHeight,
        barWidth - (spacing * 2),
        adjustedHeight,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        paint,
      );
    }

    @override
    bool shouldRepaint(AmplitudePainter oldDelegate) {
      return oldDelegate.amplitude != amplitude ||
          oldDelegate.isRecording != isRecording ||
          oldDelegate.color != color;
    }
  }
}
