import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/models/sub_category_model.dart';

class SubCategoryProvider extends StateNotifier<List<SubCategoriesModel>>{
  SubCategoryProvider() : super([]);

  void setCategory(List<SubCategoriesModel> category){
    state = category;
  }
}

final subCategoryProvider = StateNotifierProvider<SubCategoryProvider,List<SubCategoriesModel>>(
  (ref) {
    return SubCategoryProvider();
  }
);