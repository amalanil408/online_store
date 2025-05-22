import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_store/global_variables.dart';
import 'package:online_store/models/banner_model.dart';

class BannerController {

  Future<List<BannerModel>> loadbanners() async {
    try {
      http.Response response =  await http.get(Uri.parse("$uri/api/banner"),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8'
      }
      );
      print(response.body);
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =  data.map((source) => BannerModel.fromMap(source)).toList();
        return banners;
      } else {
        throw Exception("Failed to load banners");
      }
    } catch (e) {
      throw Exception("Error loading Banners : $e");
      
    }
  }
}