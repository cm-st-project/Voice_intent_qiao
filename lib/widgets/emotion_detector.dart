import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'dart:io';
import '../services/emotion_service.dart';
import '../models/emotion_result.dart';
import 'dart:async';

class EmotionDetector extends StatefulWidget {
  final EmotionService emotionService;

  const EmotionDetector({Key? key, required this.emotionService})
    : super(key: key);

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
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    final hasPermission = await _audioRecorder.hasPermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Microphone permission not granted')),
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
        _recordingPath = '${tempDir.path}/temp_recording.wav';

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
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error starting recording: $e')));
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
      ).showSnackBar(SnackBar(content: Text('Error pausing recording: $e')));
    }
  }

  Future<void> _resumeRecording() async {
    try {
      await _audioRecorder.resume();
      setState(() {
        _isPaused = false;
      });
      _startAmplitudeListener();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error resuming recording: $e')));
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _audioRecorder.stop();
      _stopDurationTimer();
      setState(() {
        _isRecording = false;
        _isPaused = false;
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
          await file.delete();
        }
      }
    } catch (e) {
      setState(() {
        _isAnalyzing = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error stopping recording: $e')));
    }
  }

  void _startAmplitudeListener() {
    Future.doWhile(() async {
      if (!_isRecording || _isPaused) return false;

      try {
        final amplitude = await _audioRecorder.getAmplitude();
        setState(() {
          _amplitude = amplitude.current;
        });
      } catch (e) {
        debugPrint('Error getting amplitude: $e');
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
    String twoDigits(int n) => n.toString().padLeft(2, '0');
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          if (_isRecording) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Recording ${_formatDuration(_recordingDuration)}',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: _isRecording ? _stopRecording : _startRecording,
                icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                color:
                    _isRecording
                        ? Colors.red
                        : Theme.of(context).colorScheme.primary,
                iconSize: 32,
              ),
            ),
          ),
          if (_isRecording)
            IconButton(
              onPressed: _isPaused ? _resumeRecording : _pauseRecording,
              icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
              tooltip: _isPaused ? 'Resume Recording' : 'Pause Recording',
            ),
          const SizedBox(height: 32),
          if (_isAnalyzing) ...[
            Column(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                    strokeWidth: 4,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Analyzing emotions...',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ] else if (_lastResult != null) ...[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.psychology,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Detected Emotions',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ..._lastResult!.topEmotions.map((emotion) {
                    final emotionColors = _getEmotionColor(context);
                    final color =
                        emotionColors[emotion.name] ??
                        Theme.of(context).colorScheme.primary;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Text(
                                    emotion.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${(emotion.score * 100).toStringAsFixed(1)}%',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium?.copyWith(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: emotion.score,
                              backgroundColor: color.withOpacity(0.1),
                              valueColor: AlwaysStoppedAnimation<Color>(color),
                              minHeight: 8,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
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
  }

  @override
  bool shouldRepaint(AmplitudePainter oldDelegate) {
    return oldDelegate.amplitude != amplitude ||
        oldDelegate.isRecording != isRecording ||
        oldDelegate.color != color;
  }
}
