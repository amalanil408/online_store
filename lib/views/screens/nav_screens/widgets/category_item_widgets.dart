import 'package:flutter/material.dart';
import 'package:online_store/controllers/category_controller.dart';
import 'package:online_store/core/widgets/reusable_text_widget.dart';
import 'package:online_store/models/category_model.dart';
import 'package:online_store/views/detail/screens/inner_category_screen.dart';

class CategoryItemWidgets extends StatefulWidget {
  const CategoryItemWidgets({super.key});

  @override
  State<CategoryItemWidgets> createState() => _CategoryItemWidgetsState();
}

class _CategoryItemWidgetsState extends State<CategoryItemWidgets> {
  final CategoryController _categoryController = CategoryController();
  late Future<List<CategoryModel>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = _categoryController.loadCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableTextWidget(title: "Categories", subTitle: "View All"),
        const SizedBox(height: 10,),
        FutureBuilder(
          future: futureCategories, 
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: const CircularProgressIndicator());
            } else if(snapshot.hasError){
              return Center(child: Text("Error ${snapshot.error}"),);
            } else if(!snapshot.hasData || snapshot.data!.isEmpty){
              return Center(child: Text("No Categories"),);
            } else {
              final categories = snapshot.data!;
              return GridView.builder(
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
                );
            }
          },
          ),
      ],
    );
  }
}