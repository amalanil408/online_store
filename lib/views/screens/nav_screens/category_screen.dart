import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_store/controllers/category_controller.dart';
import 'package:online_store/controllers/sub_category_controller.dart';
import 'package:online_store/models/category_model.dart';
import 'package:online_store/provider/category_provider.dart';
import 'package:online_store/provider/sub_category_provider.dart';
import 'package:online_store/views/detail/screens/sub_category_product_screen.dart';
import 'package:online_store/views/detail/screens/widgets/sub_category_tile_widget.dart';
import 'package:online_store/views/screens/nav_screens/widgets/header_widgets.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final categories = await CategoryController().loadCategories();
    ref.read(categoryProvider.notifier).setCategory(categories);
    for (var category in categories) {
      if (category.name == 'Fashion') {
        setState(() {
          _selectedCategory = category;
        });
        _fetchSubcategories(category.name);
      }
    }
  }

  Future<void> _fetchSubcategories(String categoryName) async {
    final subCategory = await SubCategoryController()
        .getSubCategoriesByCategoryName(categoryName);
    ref.read(subCategoryProvider.notifier).setCategory(subCategory);
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    final subCategories = ref.watch(subCategoryProvider);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 20,
          ),
          child: HeaderWidgets(),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey.shade200,
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return ListTile(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                        _fetchSubcategories(category.name);
                      },
                      title: Text(
                        category.name,
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color:
                              _selectedCategory == category
                                  ? Colors.blue
                                  : Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Expanded(
              flex: 5,
              child:
                  _selectedCategory != null
                      ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _selectedCategory!.name,
                                style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.7,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      _selectedCategory!.banner,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            subCategories.isNotEmpty
                                ? GridView.builder(
                                  itemCount: subCategories.length,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 4,
                                        childAspectRatio: 2 / 3,
                                      ),
                                  itemBuilder: (context, index) {
                                    final subcategory = subCategories[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SubCategoryProductScreen(subCategory: subcategory)));
                                      },
                                      child: SubCategoryTileWidget(
                                        image: subcategory.image,
                                        title: subcategory.subCategoryName,
                                      ),
                                    );
                                  },
                                )
                                : Center(
                                  child: Text(
                                    "No Sub Category",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      )
                      : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
