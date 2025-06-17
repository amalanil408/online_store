import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/models/product_model.dart';

final subCategoryProductsProvider = StateNotifierProvider.family<
  SubCategoryProductsNotifier,
  List<ProductModel>,
  String
>((ref, subCategoryName) {
  return SubCategoryProductsNotifier();
});

class SubCategoryProductsNotifier extends StateNotifier<List<ProductModel>> {
  SubCategoryProductsNotifier() : super([]);

  void setProducts(List<ProductModel> products) {
    state = products;
  }
}
