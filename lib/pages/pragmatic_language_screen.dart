import 'package:flutter/material.dart';
import '../constants/constant.dart';
import '../services/emotion_service.dart';
import '../models/pragmatic_result.dart';

class PragmaticLanguageScreen extends StatefulWidget {
  const PragmaticLanguageScreen({super.key});

  @override
  State<PragmaticLanguageScreen> createState() =>
      _PragmaticLanguageScreenState();
}

class _PragmaticLanguageScreenState extends State<PragmaticLanguageScreen> {
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
                      "Pragmatic Language",
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
