import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/domain/service/ingredient_service.dart';
import 'package:mobile_nutrimiski/model/entitie/ingredient.dart';

class IngredientPresenter extends ChangeNotifier {

  final IngredientService _ingredientService = IngredientService();

  List<Ingredient> _ingredientsList = [];

  getIngredientsList() {
    return _ingredientsList;
  }

  setIngredientsList(List<Ingredient> newList) {
    _ingredientsList = newList;
    notifyListeners();
  }

  Future<bool> getAllIngredients() async {

    //HAGO EL CONTROLADOR PARA EVITAR QUE EL RETURN SE SALGA A PESAR DE SER TRUE,
    //DE ESTA MANERA, SI SE VUELVE TRUE SE ASIGNA EL VALOR AL CONTROLLER Y RETORNARÁ
    //SIEMPRE EL VALOR ESPERADO

    bool responseController = false;

    await _ingredientService.getAllIngredients().then((ingredientsListResponse){
      setIngredientsList(ingredientsListResponse);
      if(ingredientsListResponse.isNotEmpty) {
        responseController = true;
        return responseController;
      }
    });

    return responseController;
  }
}