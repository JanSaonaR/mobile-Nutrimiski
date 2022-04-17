class ReplaceMealDto {
  final double? carbohydrates;
  final double? fat;
  final double? gramsPortion;
  final String? imageUrl;
  final String? ingredients;
  final int? mealId;
  final String? name;
  final double? protein;
  final double? totalCalories;

  ReplaceMealDto({
    this.carbohydrates,
    this.fat,
    this.gramsPortion,
    this.imageUrl,
    this.ingredients,
    this.mealId,
    this.name,
    this.protein,
    this.totalCalories,
  });

  Map toJson() => {
    'carbohydrates': carbohydrates,
    'fat': fat,
    'gramsPortion': gramsPortion,
    'imageUrl': imageUrl,
    'ingredients': ingredients,
    'mealId': mealId,
    'name': name,
    'protein': protein,
    'totalCalories': totalCalories
  };

}