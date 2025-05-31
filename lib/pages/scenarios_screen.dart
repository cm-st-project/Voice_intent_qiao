import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Container(
        child: Column(children: [Text("This is the ScenariosScreen")]),
      ),
    );
  }
}
