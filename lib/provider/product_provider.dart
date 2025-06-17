import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/models/product_model.dart';

class ProductProvider extends StateNotifier<List<ProductModel>>{
  ProductProvider() : super([]);

  void setProducts(List<ProductModel> product){
    state = product;
  }
}

final productProvider = StateNotifierProvider<ProductProvider,List<ProductModel>>(
  (ref) {
    return ProductProvider();
  }
);