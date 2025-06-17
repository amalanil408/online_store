import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/models/category_model.dart';

class CategoryProvider extends StateNotifier<List<CategoryModel>>{
  CategoryProvider() : super([]);

  void setCategory(List<CategoryModel> category){
    state = category;
  }
}

final categoryProvider = StateNotifierProvider<CategoryProvider,List<CategoryModel>>(
  (ref) {
    return CategoryProvider();
  }
);