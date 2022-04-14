class CategoryIngredient {
  final int? ingredientId;
  final String? name;

  CategoryIngredient({
    this.ingredientId,
    this.name
  });

  factory CategoryIngredient.fromJson(dynamic json) {
    Map<String, dynamic> categoryIngredientJson = json;
    return CategoryIngredient(
      ingredientId: categoryIngredientJson['ingredientId'],
      name: categoryIngredientJson['name']
    );
  }

  Map toJson() => {
    'ingredientId': ingredientId,
    'name': name
  };

}