import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_store/global_variables.dart';
import 'package:online_store/models/category_model.dart';

class CategoryController {

  Future<List<CategoryModel>> loadCategories() async {
    try {
      http.Response response =  await http.get(Uri.parse("$uri/api/categories"),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8'
      }
      );

      if(response.statusCode == 200){
        List<dynamic> data =  jsonDecode(response.body);
        List<CategoryModel> categories = data.map((category) => CategoryModel.fromJson(category)).toList();
        return categories;
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error loading categories : $e");
    }
  }
}