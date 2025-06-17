import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/models/product_model.dart';

class TopRatedProductProvider extends StateNotifier<List<ProductModel>>{
  TopRatedProductProvider() : super([]);

  void setProducts(List<ProductModel> product){
    state = product;
  }
}

final topRatedProductProvider = StateNotifierProvider<TopRatedProductProvider,List<ProductModel>>(
  (ref) {
    return TopRatedProductProvider();
  }
);