import 'package:dio/dio.dart';
import 'package:mobile_nutrimiski/model/entitie/ingredient.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';

import '../../model/entitie/user_session.dart';

class IngredientService {
  IngredientService();

  Future<List<Ingredient>> getAllIngredients() async {
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    var uri = baseUrl + ingredientsEndpoint;

    var response = await dio.get(uri);

    if(response.statusCode == 200) {
      List<Ingredient> ingredientsList =
        response.data.map((e) => Ingredient.fromJson(e)).toList();
      return ingredientsList;
    }

    return [];
  }

}