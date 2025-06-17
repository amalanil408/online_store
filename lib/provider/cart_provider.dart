import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


final cartProvider = StateNotifierProvider<CartNotifier,Map<String,CartModel>>(
  (ref) {
    return CartNotifier();
  }
);
class CartNotifier extends StateNotifier<Map<String,CartModel>>{
  CartNotifier() : super({}) {
    _loadCarts();
  }

  Future<void> _loadCarts() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final cartString =  sharedPreferences.getString('cart');
    if(cartString != null){
      final Map<String,dynamic> cartMap = jsonDecode(cartString);
      final cart = cartMap.map((key,value) => MapEntry(key, CartModel.fromJson(value)));
      state = cart;
    }
  }

  Future<void> _saveCart() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final cartString =  jsonEncode(state);
    await sharedPreferences.setString('cart', cartString);
  }

  void addProductToCart({
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
    if(state.containsKey(productId)){
      state = {
        ...state,
        productId:CartModel(
        productName: state[productId]!.productName, 
        productPrice: state[productId]!.productPrice, 
        category: state[productId]!.category, 
        image: state[productId]!.image, 
        vendorId: state[productId]!.vendorId, 
        productQuantity: state[productId]!.productQuantity, 
        quantity: state[productId]!.quantity + 1, 
        productId: state[productId]!.productId, 
        description: state[productId]!.description, 
        fullName: state[productId]!.fullName
        )
      };
      _saveCart();
    } else {
      state = {
        ...state,
        productId : CartModel(
          productName: productName, 
          productPrice: productPrice, 
          category: category, 
          image: image, 
          vendorId: vendorId, 
          productQuantity: productQuantity, 
          quantity: quantity, 
          productId: productId, 
          description: description, 
          fullName: fullName
          )
      };
      _saveCart();
    }
  }


  void incrementCartItem(String productId){
    if(state.containsKey(productId)){
      state[productId]!.quantity++;

      state = {...state};
      _saveCart();
    }
  }


  void decrementCartItem(String productId){
    if(state.containsKey(productId)){
      state[productId]!.quantity--;

      state = {...state};
      _saveCart();
    }
  }


  void removeCartItem(String productId){
    state.remove(productId);

    state = {...state};
    _saveCart();
  }

  double calculateTotalAmount(){
    double totalAmount = 0.0;
    state.forEach((productId,cartItem){
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmount;
  }


  void clearCart() {
    state = {};

    state = {...state};

    _saveCart();
  }

  Map<String,CartModel> get getCartItems => state;
}