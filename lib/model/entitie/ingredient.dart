class Ingredient {
  final int? ingredientId;
  final String? name;
  final int? categoryId;

  Ingredient({
    this.categoryId,
    this.ingredientId,
    this.name
  });

  factory Ingredient.fromJson(dynamic json) {
    Map<String, dynamic> ingredientJson = json;
    return Ingredient(
      categoryId: ingredientJson['category']['categoryId'],
      ingredientId: ingredientJson['ingredientId'],
      name: ingredientJson['name']
    );
  }

}