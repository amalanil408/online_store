import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_store/controllers/category_controller.dart';
import 'package:online_store/controllers/sub_category_controller.dart';
import 'package:online_store/models/category_model.dart';
import 'package:online_store/models/sub_category_model.dart';
import 'package:online_store/views/screens/nav_screens/widgets/header_widgets.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryController _categoryController = CategoryController();
  final SubCategoryController _subCategoryController = SubCategoryController();
  late Future<List<CategoryModel>> futureCategories;
  CategoryModel? _selectedCategory;
  List<SubCategoriesModel> _subcategoires = [];

  @override
  void initState() {
    super.initState();
    futureCategories = _categoryController.loadCategories();
    futureCategories.then((categories) {
      for(var category in categories){
        if(category.name == "Baby"){
          setState(() {
            _selectedCategory = category;
          });

          _loadSubCategories(category.name);
        }
      }
    });
  }

  Future<void> _loadSubCategories(String categoryName) async {
    final subCategories = await _subCategoryController.getSubCategoriesByCategoryName(categoryName);
    setState(() {
      _subcategoires = subCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 20,
          ),
          child: HeaderWidgets(),
        ),
        body: Row(
          children: [
            Expanded(flex: 2, child: Container(
              color: Colors.grey.shade200,
              child: FutureBuilder(
                future: futureCategories, 
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  } else if(snapshot.hasError){
                    return Center(child: Text("Error ${snapshot.error}"),);
                  } else if(!snapshot.hasData || snapshot.data!.isEmpty){
                    return Center(child: Text("No Categories"),);
                  } else {
                    final categories = snapshot.data!;
                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                            _loadSubCategories(category.name);
                          },
                          title: Text(category.name,style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: _selectedCategory == category ? Colors.blue : Colors.black
                          ),),
                        );
                      },
                      );
                  }
                },
                ),
              )),
            
            Expanded(
              flex: 5,
              child: _selectedCategory !=null ? 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_selectedCategory!.name,style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.7
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(_selectedCategory!.banner),
                        fit: BoxFit.cover
                        )
                      ),
                    ),
                  ),
                  _subcategoires.isNotEmpty ?  GridView.builder(
                    itemCount: _subcategoires.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 4
                      ), 
                    itemBuilder: (context, index) {
                      final subcategory = _subcategoires[index];
                      return Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey
                            ),
                            child: Center(
                              child: Image.network(subcategory.image,fit: BoxFit.cover,),
                            ),
                          ),
                          Center(child: Text(subcategory.subCategoryName,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),)
                        ],
                      );
                    },
                    ) : Center(child: Text("No Sub Category",style: TextStyle(fontWeight: FontWeight.bold),),)
                ],
              ) : 
              Container()
            )
          ],
        ),
      ),
    );
  }
}
