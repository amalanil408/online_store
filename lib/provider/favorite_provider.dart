import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/models/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


final favoriteProvider = StateNotifierProvider<FavoriteProvider,Map<String,FavoriteModel>>(
  (ref) {
    return FavoriteProvider();
  }
);
class FavoriteProvider extends StateNotifier<Map<String, FavoriteModel>> {
  FavoriteProvider() : super({}) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final favoriteString =  sharedPreferences.getString('favorites');
    if(favoriteString != null){
      final Map<String,dynamic> favoriteMap = jsonDecode(favoriteString);
      final favorite = favoriteMap.map((key,value) => MapEntry(key, FavoriteModel.fromJson(value)));
      state = favorite;
    }
  }

  Future<void> _saveFavorites() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final favoriteString =  jsonEncode(state);
    await sharedPreferences.setString('favorites', favoriteString);
  }

  void addProductsToFavorite({
    required String productName,
    required int productPrice,
    required String category,
    required List<String> image,
    required String vendorId,
    required int productQuantity,
    required int quantity,
    required String productId,
    required String description,
    required String fullName,
  }) {
    state[productId] = FavoriteModel(
      productName: productName,
      productPrice: productPrice,
      category: category,
      image: image,
      vendorId: vendorId,
      productQuantity: productQuantity,
      quantity: quantity,
      productId: productId,
      description: description,
      fullName: fullName,
    );

    state = {...state};
    _saveFavorites();
  }

  void removeFavoriteItem(String productId){
    state.remove(productId);

    state = {...state}; 
    _saveFavorites();
  }

  Map<String,FavoriteModel> get getFavoriteItems => state;
}
