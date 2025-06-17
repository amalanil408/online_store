import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/models/product_model.dart';

class RelatedProductProvider extends StateNotifier<List<ProductModel>>{
  RelatedProductProvider() : super([]);

  void setProducts(List<ProductModel> product){
    state = product;
  }
}

final relatedProductProvider = StateNotifierProvider<RelatedProductProvider,List<ProductModel>>(
  (ref) {
    return RelatedProductProvider();
  }
);