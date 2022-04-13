import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/domain/service/category_service.dart';

import '../model/entitie/category.dart';

class CategoryPresenter extends ChangeNotifier {

  final CategoryService _categoryService = CategoryService();

  List<Category> _categoriesList = [];

  getCategoriesList() {
    return _categoriesList;
  }

  setCategoriesList(List<Category> newList) {
    _categoriesList = newList;
    notifyListeners();
  }

  Future<bool> getAllCategories() async {
    bool responseController = false;

    await _categoryService.getAllCategories().then((categoriesListResponse){
      setCategoriesList(categoriesListResponse);
      if(categoriesListResponse.isNotEmpty) {
        responseController = true;
        return responseController;
      }
    });

    return responseController;
  }

}