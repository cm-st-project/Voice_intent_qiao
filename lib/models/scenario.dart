class Scenario {
  final String subcategory;
  final String description;
  final String action;
  final String why;

  Scenario({
    required this.subcategory,
    required this.description,
    required this.action,
    required this.why,
  });

  factory Scenario.fromJson(Map<String, dynamic> json) {
    return Scenario(
      subcategory: json['subcategory'] as String,
      description: json['description'] as String,
      action: json['action'] as String,
      why: json['why'] as String,
    );
  }
}

class ScenarioCategory {
  final String name;
  final List<Scenario> scenarios;
  ScenarioCategory({required this.name, required this.scenarios});
  factory ScenarioCategory.fromJson(String name, List<dynamic> scenariosJson) {
    return ScenarioCategory(
      name: name,
      scenarios:
          scenariosJson
              .map(
                (scenario) =>
                    Scenario.fromJson(scenario as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}
