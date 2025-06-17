import 'dart:convert';
import 'package:online_store/global_variables.dart';
import 'package:online_store/models/product_model.dart';
import 'package:http/http.dart' as http;


class ProductController {

  Future<List<ProductModel>> loadPopularProducts() async {
    try {
      http.Response response =  await http.get(Uri.parse("$uri/api/popular-products"),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8'
      }
      );

      if(response.statusCode == 200){
        final List<dynamic> data =  jsonDecode(response.body) as List<dynamic>;
        List<ProductModel> products = data.map((product) => ProductModel.fromJson(product)).toList();
        return products;
      } else if(response.statusCode == 404){
        return [];
      } 
      else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error loading categories : $e");
    }
  }


  Future<List<ProductModel>> loadProductsByCategory(String category) async {
    try {
      http.Response response =  await http.get(Uri.parse("$uri/api/products-by-category/$category"),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8'
      }
      );

      if(response.statusCode == 200){
        final List<dynamic> data =  jsonDecode(response.body) as List<dynamic>;
        List<ProductModel> products = data.map((product) => ProductModel.fromJson(product)).toList();
        return products;
      } else if(response.statusCode == 404){
        return [];
      }
      else if(response.statusCode == 404){
        return [];
      }
      else {
        return [];
      }
    } catch (e) {
      throw Exception("Error loading categories : $e");
    }
  }


  Future<List<ProductModel>> loadRelatedProductBySubcategory(String productId) async {
    try {
      http.Response response =  await http.get(Uri.parse("$uri/api/related-product-by-subcategory/$productId"),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8'
      }
      );

      if(response.statusCode == 200){
        final List<dynamic> data =  jsonDecode(response.body) as List<dynamic>;
        List<ProductModel> relatedProduct = data.map((product) => ProductModel.fromJson(product)).toList();
        return relatedProduct;
      } 
      else if(response.statusCode == 404){
        return [];
      }
      else {
        throw Exception("Failed to load related product");
      }
    } catch (e) {
      throw Exception("Error loading related product : $e");
    }
  }




  Future<List<ProductModel>> loadTopRatedProduct() async {
    try {
      http.Response response =  await http.get(Uri.parse("$uri/api/top-rated-products"),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8'
      }
      );

      if(response.statusCode == 200){
        final List<dynamic> data =  jsonDecode(response.body) as List<dynamic>;
        List<ProductModel> topRatedProduct = data.map((product) => ProductModel.fromJson(product)).toList();
        return topRatedProduct;
      } 
      else if(response.statusCode == 404){
        return [];
      } 
      else {
        throw Exception("Failed to load top rated product");
      }
    } catch (e) {
      throw Exception("Error loading top rated product : $e");
    }
  }


  Future<List<ProductModel>> loadProductBySubcategory(String subCategory) async {
    try {
      http.Response response =  await http.get(Uri.parse("$uri/api/products-by-subcategory/$subCategory"),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8'
      }
      );

      if(response.statusCode == 200){
        final List<dynamic> data =  jsonDecode(response.body) as List<dynamic>;
        List<ProductModel> relatedProduct = data.map((product) => ProductModel.fromJson(product)).toList();
        return relatedProduct;
      } 
      else if(response.statusCode == 404){
        return [];
      }
      else {
        throw Exception("Failed to load sub category product");
      }
    } catch (e) {
      throw Exception("Error loading sub category product : $e");
    }
  }




  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      http.Response response =  await http.get(Uri.parse("$uri/api/search-products?query=$query"),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8'
      }
      );

      if(response.statusCode == 200){
        final List<dynamic> data =  jsonDecode(response.body) as List<dynamic>;
        List<ProductModel> searchedProduct = data.map((product) => ProductModel.fromJson(product)).toList();
        return searchedProduct;
      } 
      else if(response.statusCode == 404){
        return [];
      }
      else {
        throw Exception("Failed to load searched product");
      }
    } catch (e) {
      throw Exception("Error loading searched product : $e");
    }
  }
}