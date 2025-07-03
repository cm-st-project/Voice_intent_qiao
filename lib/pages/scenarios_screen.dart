import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_mickey/constants/constant.dart';
import '../services/emotion_service.dart';
import '../widgets/emotion_detector.dart';
import '../models/scenario.dart';
import '../constants/scenarios.dart' as scenarios_data;

class ScenariosScreen extends StatefulWidget {
  const ScenariosScreen({super.key});

  @override
  State<ScenariosScreen> createState() => _ScenariosScreenState();
}

class _ScenariosScreenState extends State<ScenariosScreen> {
  final EmotionService _emotionService = EmotionService(
    baseUrl: 'http://localhost:8000',
  );

  late List<ScenarioCategory> _categories;
  late ScenarioCategory _currentCategory;
  int _currentScenarioIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeScenarios();
  }

  void _initializeScenarios() {
    _categories =
        scenarios_data.scenarios.entries
            .map((entry) => ScenarioCategory.fromJson(entry.key, entry.value))
            .toList();
    _currentCategory = _categories.first;
  }

  void _nextScenario() {
    setState(() {
      if (_currentScenarioIndex < _currentCategory.scenarios.length - 1) {
        _currentScenarioIndex++;
      } else {
        int currentCategoryIndex = _categories.indexOf(_currentCategory);
        if (currentCategoryIndex < _categories.length - 1) {
          _currentCategory = _categories[currentCategoryIndex + 1];
          _currentScenarioIndex = 0;
        }
      }
    });
  }

  void _previousScenario() {
    setState(() {
      if (_currentScenarioIndex > 0) {
        _currentScenarioIndex--;
      } else {
        int currentCategoryIndex = _categories.indexOf(_currentCategory);
        if (currentCategoryIndex > 0) {
          _currentCategory = _categories[currentCategoryIndex - 1];
          _currentScenarioIndex = _currentCategory.scenarios.length - 1;
        }
      }
    });
  }

  void _selectCategory(ScenarioCategory category) {
    setState(() {
      _currentCategory = category;
      _currentScenarioIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentScenario = _currentCategory.scenarios[_currentScenarioIndex];

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
                      "Pragmatic Scenarios",
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
              _buildCategorySelector(),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                    children: [
                      Expanded(
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
                                          Icons.category,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            currentScenario.subcategory,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    _buildScenarioSection(
                                      context,
                                      "Situation",
                                      currentScenario.description,
                                      Icons.info_outline,
                                    ),
                                    _buildScenarioSection(
                                      context,
                                      "Expected Action",
                                      currentScenario.action,
                                      Icons.psychology,
                                    ),
                                    _buildScenarioSection(
                                      context,
                                      "Why",
                                      currentScenario.why,
                                      Icons.lightbulb_outline,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed:
                                  _currentScenarioIndex > 0 ||
                                          _categories.indexOf(
                                                _currentCategory,
                                              ) >
                                              0
                                      ? _previousScenario
                                      : null,
                              icon: const Icon(Icons.arrow_back_ios),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Scenario ${_currentScenarioIndex + 1} of ${_currentCategory.scenarios.length}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _currentCategory.name,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withOpacity(0.7),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed:
                                  _currentScenarioIndex <
                                              _currentCategory
                                                      .scenarios
                                                      .length -
                                                  1 ||
                                          _categories.indexOf(
                                                _currentCategory,
                                              ) <
                                              _categories.length - 1
                                      ? _nextScenario
                                      : null,
                              icon: const Icon(Icons.arrow_forward_ios),
                              color: Theme.of(context).colorScheme.primary,
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

  Widget _buildCategorySelector() {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _currentCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category.name),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  _selectCategory(category);
                }
              },
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.2),
              labelStyle: TextStyle(
                color:
                    isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color:
                      isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                            context,
                          ).colorScheme.outline.withOpacity(0.5),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScenarioSection(
    BuildContext context,
    String title,
    String content,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
