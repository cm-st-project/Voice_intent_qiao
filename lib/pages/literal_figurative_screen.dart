import 'package:flutter/material.dart';
import '../constants/constant.dart';
import '../services/emotion_service.dart';
import '../models/literal_result.dart';
import '../widgets/speech_input.dart';

class LiteralFigurativeScreen extends StatefulWidget {
  const LiteralFigurativeScreen({super.key});

  @override
  State<LiteralFigurativeScreen> createState() =>
      _LiteralFigurativeScreenState();
}

class _LiteralFigurativeScreenState extends State<LiteralFigurativeScreen> {
  final TextEditingController _textController = TextEditingController();
  LiteralResult? _analysis;
  bool _isAnalyzing = false;
  final EmotionService _emotionService = EmotionService(baseUrl: BASE_URL);

  Future<void> _analyzeLanguage() async {
    if (_textController.text.isEmpty) return;

    setState(() {
      _isAnalyzing = true;
      _analysis = null;
    });
    final result = await _emotionService.analyzeLiteralFigurative(
      _textController.text,
    );
    setState(() {
      _analysis = result;
      _isAnalyzing = false;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
              Theme.of(context).colorScheme.secondary.withValues(alpha: 0.05),
              Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Literal vs. Figurative',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.psychology,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Understanding\nLanguage Types',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              _buildLanguageTypeCard(
                                context,
                                'Literal',
                                'Direct meaning of words (e.g., "It\'s raining" means actual rain)',
                                Colors.blue.shade100,
                              ),
                              const SizedBox(height: 8),
                              _buildLanguageTypeCard(
                                context,
                                'Figurative',
                                'Symbolic or metaphorical meaning (e.g., It\'s raining cats and dogs)',
                                Colors.purple.shade100,
                              ),
                              const SizedBox(height: 8),

                              _buildLanguageTypeCard(
                                context,
                                'Sarcastic',
                                'Saying the opposite of what you mean (e.g., "Great weather!" during a storm)',
                                Colors.orange.shade100,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        SpeechInput(
                          textController: _textController,
                          onInputComplete: _analyzeLanguage,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _isAnalyzing ? null : _analyzeLanguage,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child:
                              _isAnalyzing
                                  ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(),
                                  )
                                  : const Text('Analyze'),
                        ),
                        if (_analysis != null) ...[
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildAnalysisSection(
                                  context,
                                  'Type of Language',
                                  _analysis!.classification,
                                  Icons.category,
                                  chipColor: _getLanguageTypeColor(
                                    _analysis!.classification,
                                  ),
                                ),
                                _buildAnalysisSection(
                                  context,
                                  'What it Really Means',
                                  _analysis!.meaning,
                                  Icons.lightbulb_outline,
                                ),
                                _buildAnalysisSection(
                                  context,
                                  'Why this Type?',
                                  _analysis!.why,
                                  Icons.help_outline,
                                ),
                                _buildAnalysisSection(
                                  context,
                                  'How to Understand/\nRespond',
                                  _analysis!.suggestedUnderstandingOrReply,
                                  Icons.chat_bubble_outline,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageTypeCard(
    BuildContext context,
    String type,
    String description,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              type,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisSection(
    BuildContext context,
    String title,
    String content,
    IconData icon, {
    Color? chipColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (chipColor != null) ...[
          Chip(
            label: Text(
              content,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            backgroundColor: chipColor,
          ),
        ] else
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
      ],
    );
  }

  Color _getLanguageTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'literal':
        return Colors.blue.shade100;
      case 'figurative':
        return Colors.purple.shade100;
      case 'sarcastic':
        return Colors.orange.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
}
