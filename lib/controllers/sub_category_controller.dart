import 'dart:convert';

import 'package:online_store/global_variables.dart';
import 'package:online_store/models/sub_category_model.dart';
import 'package:http/http.dart' as http;

class SubCategoryController {

  Future<List<SubCategoriesModel>> getSubCategoriesByCategoryName(String categoryName) async {
    try {
      http.Response response =  await http.get(Uri.parse("$uri/api/category/$categoryName/subcategories"),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8'
      }
      );

      if(response.statusCode == 200){
        final List<dynamic> data = json.decode(response.body);
        
        if(data.isNotEmpty){
          return data.map((subcategory) => SubCategoriesModel.fromJson(subcategory)).toList();
        } else {
          print("Sub category not found");
          return [];
        }

      } else if(response.statusCode == 404){
        print("Sub category not found");
        return [];
      }
      else {
        print("Failed to fetch sub categories");
        return [];
      }
    } catch (e) {
      print("error fetching sub categroies $e");
      return[];
    }
  }

}