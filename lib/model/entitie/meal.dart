class Meal {
  final int? mealId;
  final String? day;
  final String? schedule;
  final String? name;
  final double? protein;
  final double? fat;
  final double? carbohydrates;
  final String? ingredients;
  final double? totalCalories;
  final double? gramsPortion;
  final String? imageUrl;
  final int? status;

  Meal({
    this.mealId,
    this.day,
    this.schedule,
    this.name,
    this.protein,
    this.fat,
    this.carbohydrates,
    this.ingredients,
    this.totalCalories,
    this.gramsPortion,
    this.imageUrl,
    this.status
  });

  factory Meal.fromJson(dynamic json) {
    Map<String,dynamic> mealJson = json;

    return Meal(
      mealId: mealJson['mealId'],
      day: mealJson['day'],
      schedule: mealJson['schedule'],
      name: mealJson['name'],
      protein: mealJson['protein'].toDouble(),
      fat: mealJson['fat'].toDouble(),
      carbohydrates: mealJson['carbohydrates'].toDouble(),
      ingredients: mealJson['ingredients'],
      totalCalories: mealJson['totalCalories'].toDouble(),
      gramsPortion: mealJson['gramsPortion'].toDouble(),
      imageUrl: mealJson['imageUrl'],
      status: mealJson['status']
    );

  }

}