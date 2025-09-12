import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';

class LanguageSwitchButton extends StatelessWidget {
  const LanguageSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context);
    
    return PopupMenuButton<Locale>(
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.language,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 4),
            Text(
              currentLocale.languageCode == 'zh' ? '中' : 'EN',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 2),
            Icon(
              Icons.arrow_drop_down,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
      onSelected: (Locale locale) {
        MyApp.of(context)?.setLocale(locale);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<Locale>(
          value: const Locale('en'),
          child: Row(
            children: [
              const Text('🇺🇸', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                localizations.english,
                style: TextStyle(
                  fontWeight: currentLocale.languageCode == 'en' 
                      ? FontWeight.bold 
                      : FontWeight.normal,
                ),
              ),
              if (currentLocale.languageCode == 'en') ...[
                const Spacer(),
                Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                  size: 18,
                ),
              ],
            ],
          ),
        ),
        PopupMenuItem<Locale>(
          value: const Locale('zh'),
          child: Row(
            children: [
              const Text('🇨🇳', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                localizations.chinese,
                style: TextStyle(
                  fontWeight: currentLocale.languageCode == 'zh' 
                      ? FontWeight.bold 
                      : FontWeight.normal,
                ),
              ),
              if (currentLocale.languageCode == 'zh') ...[
                const Spacer(),
                Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                  size: 18,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}