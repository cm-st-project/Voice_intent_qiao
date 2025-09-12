import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'pragmatic_language_screen.dart';
import 'emotions_speech_screen.dart';
import 'literal_figurative_screen.dart';
import 'scenarios_screen.dart';
import '../widgets/language_switch_button.dart';

// This widget represents the main home screen UI.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the device's screen width and height.
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        // Apply a soft gradient background using the app's color scheme.
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
          // Ensures UI content is not obstructed by system UI like notches.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top section with logo and app title/subtitle.
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Row(
                  children: [
                    // Circular logo image.
                    ClipOval(
                      child: Image.asset(
                        'assets/logo.png',
                        width: 70,
                        height: 70,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // App name styled using theme.
                          Text(
                            AppLocalizations.of(context)!.appTitle,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          // Subtitle with reduced opacity.
                          Text(
                            AppLocalizations.of(context)!.appSubtitle,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onBackground.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Language switch button
                    const LanguageSwitchButton(),
                  ],
                ),
              ),

              const SizedBox(height: 32),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.chooseActivity,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildFeatureCard(
                                    context,
                                    title: AppLocalizations.of(context)!.pragmaticLanguage,
                                    description:
                                        AppLocalizations.of(context)!.pragmaticLanguageDesc,
                                    icon: Icons.chat_bubble_outline,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    onTap:
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    const PragmaticLanguageScreen(),
                                          ),
                                        ),
                                    height: screenHeight * 0.25,
                                  ),
                                ),
                                Expanded(
                                  child: _buildFeatureCard(
                                    context,
                                    title: AppLocalizations.of(context)!.emotionsInSpeech,
                                    description:
                                        AppLocalizations.of(context)!.emotionsInSpeechDesc,
                                    icon: Icons.sentiment_satisfied_alt,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    onTap:
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    const EmotionsSpeechScreen(),
                                          ),
                                        ),
                                    height: screenHeight * 0.25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildFeatureCard(
                                    context,
                                    title: AppLocalizations.of(context)!.literalVsFigurative,
                                    description: AppLocalizations.of(context)!.literalVsFigurativeDesc,
                                    icon: Icons.translate,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    onTap:
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    const LiteralFigurativeScreen(),
                                          ),
                                        ),
                                    height: screenHeight * 0.25,
                                  ),
                                ),
                                Expanded(
                                  child: _buildFeatureCard(
                                    context,
                                    title: AppLocalizations.of(context)!.pragmaticScenarios,
                                    description: AppLocalizations.of(context)!.pragmaticScenariosDesc,
                                    icon: Icons.people,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary.withBlue(150),
                                    onTap:
                                        () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    const ScenariosScreen(),
                                          ),
                                        ),
                                    height: screenHeight * 0.25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a customizable feature card with icon, title, and description.
  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required double height,
  }) {
    return Card(
      elevation: 0, // Flat card with no shadow.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: onTap, // Handles card tap interaction.
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: height,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: color.withOpacity(0.1), // Light tinted background.
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Circular icon container at top.
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 40, color: color),
                ),
                const SizedBox(height: 12),
                // Title and description centered below the icon.
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          height: 1.2,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
