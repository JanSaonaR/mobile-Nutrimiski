import 'category_ingredient.dart';

class Category {
  final int? categoryId;
  final List<CategoryIngredient>? ingredients;
  final String? name;

  Category({
    this.categoryId,
    this.ingredients,
    this.name
  });

  factory Category.fromJson(dynamic json) {

    var categoryIngredientsJson = json['ingredients'] as List;
    List<CategoryIngredient> categoryIngredients = categoryIngredientsJson.map((e) =>
        CategoryIngredient.fromJson(e)).toList();

    Map<String, dynamic> categoryJson = json;
    return Category(
      categoryId: categoryJson['categoryId'],
      ingredients: categoryIngredients,
      name: categoryJson['name']
    );
  }

}