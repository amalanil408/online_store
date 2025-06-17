import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/controllers/category_controller.dart';
import 'package:online_store/core/widgets/reusable_text_widget.dart';
import 'package:online_store/provider/category_provider.dart';
import 'package:online_store/views/detail/screens/inner_category_screen.dart';

class CategoryItemWidgets extends ConsumerStatefulWidget {
  const CategoryItemWidgets({super.key});

  @override
  ConsumerState<CategoryItemWidgets> createState() => _CategoryItemWidgetsState();
}

class _CategoryItemWidgetsState extends ConsumerState<CategoryItemWidgets> {

  @override
  void initState() {
    super.initState();
    _fetchCategory();
  }

  Future<void> _fetchCategory() async {
    final CategoryController categoryController = CategoryController();
    try {
      final category = await categoryController.loadCategories();
      ref.read(categoryProvider.notifier).setCategory(category);
    } catch (e) {
      throw Exception("Error fetching orders : $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableTextWidget(title: "Categories", subTitle: "View All"),
        const SizedBox(height: 10,),
        GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8
                  ), 
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => InnerCategoryScreen(category: category,)));
                    },
                    child: Column(
                      children: [
                        Image.network(category.image,height: 44,width: 100,),
                        Text(category.name,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13
                        ),),
                      ],
                    ),
                  );
                },
                )
      ],
    );
  }
}