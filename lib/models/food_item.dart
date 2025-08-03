enum Complexity {
  simple,
  challenging,
  hard,
}

enum Affordability {
  affordable,
  pricey,
  luxurious,
}

class FoodItem {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const FoodItem({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      steps: List<String>.from(json['steps'] ?? []),
      duration: json['duration'] ?? 0,
      complexity: _getComplexityFromString(json['complexity']),
      affordability: _getAffordabilityFromString(json['affordability']),
      isGlutenFree: json['isGlutenFree'] ?? false,
      isLactoseFree: json['isLactoseFree'] ?? false,
      isVegan: json['isVegan'] ?? false,
      isVegetarian: json['isVegetarian'] ?? false,
    );
  }

  static Complexity _getComplexityFromString(String? complexity) {
    switch (complexity?.toLowerCase()) {
      case 'simple':
        return Complexity.simple;
      case 'challenging':
        return Complexity.challenging;
      case 'hard':
        return Complexity.hard;
      default:
        return Complexity.simple;
    }
  }

  static Affordability _getAffordabilityFromString(String? affordability) {
    switch (affordability?.toLowerCase()) {
      case 'affordable':
        return Affordability.affordable;
      case 'pricey':
        return Affordability.pricey;
      case 'luxurious':
        return Affordability.luxurious;
      default:
        return Affordability.affordable;
    }
  }
}
