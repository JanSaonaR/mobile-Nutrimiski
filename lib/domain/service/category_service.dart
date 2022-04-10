import 'package:dio/dio.dart';
import 'package:mobile_nutrimiski/model/entitie/category.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';

import '../../model/entitie/user_session.dart';

class CategoryService {
  CategoryService();

  Future<List<Category>> getAllCategories () async {
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    var uri = baseUrl + ingredientsEndpoint + categoriesEndpoint;

    var response = await dio.get(uri);

    if(response.statusCode == 200) {
      List<Category> auxList = [];

      for(var item in response.data) {
        auxList.add(Category.fromJson(item));
      }

      return auxList;
    }

    return [];
  }
}