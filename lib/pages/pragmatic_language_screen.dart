import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../constants/constant.dart';
import '../services/emotion_service.dart';
import '../models/pragmatic_result.dart';
import '../widgets/speech_input.dart';

class PragmaticLanguageScreen extends StatefulWidget {
  const PragmaticLanguageScreen({super.key});

  @override
  State<PragmaticLanguageScreen> createState() =>
      _PragmaticLanguageScreenState();
}

class _PragmaticLanguageScreenState extends State<PragmaticLanguageScreen> {
  final TextEditingController _textController = TextEditingController();
  PragmaticResult? _analysis;
  bool _isAnalyzing = false;
  final EmotionService _emotionService = EmotionService(baseUrl: BASE_URL);

  Future<void> _analyzePragmaticLanguage() async {
    if (_textController.text.isEmpty) return;

    setState(() {
      _isAnalyzing = true;
      _analysis = null;
    });
    try {
      final result = await _emotionService.analyzePragmaticLanguage(
        _textController.text,
      );

      setState(() {
        _analysis = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Eror analyzing text: $e')));
    } finally {
      setState(() {
        _isAnalyzing = false;
      });
    }
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
              Theme.of(context).colorScheme.primary.withOpacity(0.05),
              Theme.of(context).colorScheme.secondary.withOpacity(0.05),
              Theme.of(context).colorScheme.tertiary.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      AppLocalizations.of(context)!.pragmaticLanguageTitle,
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
                        color: Colors.black.withOpacity(0.05),
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
                            ).colorScheme.primary.withOpacity(0.1),
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
                                    AppLocalizations.of(
                                      context,
                                    )!.understandingPragmaticLanguage,
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
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.pragmaticLanguageDescription,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),
                        SpeechInput(
                          textController: _textController,
                          onInputComplete: _analyzePragmaticLanguage,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed:
                              _isAnalyzing ? null : _analyzePragmaticLanguage,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child:
                              _isAnalyzing
                                  ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(),
                                  )
                                  : Text(AppLocalizations.of(context)!.analyze),
                        ),
                        if (_analysis != null) ...[
                          const SizedBox(height: 24),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.1),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildAnalysisSection(
                                  context,
                                  AppLocalizations.of(context)!.languageUse,
                                  _analysis!.pragmaticUse,
                                  Icons.language,
                                ),
                                _buildAnalysisSection(
                                  context,
                                  AppLocalizations.of(context)!.speakerIntent,
                                  _analysis!.speakerIntent,
                                  Icons.language,
                                ),
                                _buildAnalysisSection(
                                  context,
                                  AppLocalizations.of(context)!.whatItMeans,
                                  _analysis!.interpretation,
                                  Icons.language,
                                ),
                                _buildAnalysisSection(
                                  context,
                                  AppLocalizations.of(
                                    context,
                                  )!.suggestedResponse,
                                  _analysis!.suggestedResponse,
                                  Icons.language,
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

  Widget _buildAnalysisSection(
    BuildContext context,
    String title,
    String content,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
