import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_store/controllers/product_controller.dart';
import 'package:online_store/controllers/sub_category_controller.dart';
import 'package:online_store/core/widgets/common_widget.dart';
import 'package:online_store/core/widgets/reusable_text_widget.dart';
import 'package:online_store/models/category_model.dart';
import 'package:online_store/models/product_model.dart';
import 'package:online_store/models/sub_category_model.dart';
import 'package:online_store/views/detail/screens/sub_category_product_screen.dart';
import 'package:online_store/views/detail/screens/widgets/inner_banner_widget.dart';
import 'package:online_store/views/detail/screens/widgets/inner_header_widget.dart';
import 'package:online_store/views/detail/screens/widgets/sub_category_tile_widget.dart';
import 'package:online_store/views/screens/nav_screens/widgets/product_item_widget.dart';

class InnerCategoryWidget extends StatefulWidget {
  final CategoryModel category;
  const InnerCategoryWidget({super.key, required this.category});

  @override
  State<InnerCategoryWidget> createState() => _InnerCategoryWidgetState();
}

class _InnerCategoryWidgetState extends State<InnerCategoryWidget> {
  late Future<List<SubCategoriesModel>> _subCategories;
  late Future<List<ProductModel>> futureProducts;
  final SubCategoryController _subCategoryController = SubCategoryController();
  final ProductController productController = ProductController();

  @override
  void initState() {
    super.initState();
    _subCategories = _subCategoryController.getSubCategoriesByCategoryName(
      widget.category.name,
    );
    futureProducts = productController.loadProductsByCategory(
      widget.category.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 20),
        child: InnerHeaderWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidget(image: widget.category.banner),
            Center(
              child: Text(
                "Shop by categories",
                style: GoogleFonts.quicksand(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.7,
                ),
              ),
            ),
            customSizedBox(heigh: 10),
            FutureBuilder(
              future: _subCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No Sub Categories"));
                } else {
                  final subCategories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: List.generate(
                        (subCategories.length / 7).ceil(),
                        (setIndex) {
                          final start = setIndex * 7;
                          final end = (setIndex + 1) * 7;
                          return Padding(
                            padding: EdgeInsets.all(8.9),
                            child: Row(
                              children:
                                  subCategories
                                      .sublist(
                                        start,
                                        end > subCategories.length
                                            ? subCategories.length
                                            : end,
                                      )
                                      .map(
                                        (subcategory) => GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SubCategoryProductScreen(subCategory: subcategory)));
                                          },
                                          child: SubCategoryTileWidget(
                                            image: subcategory.image,
                                            title: subcategory.subCategoryName,
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
            ReusableTextWidget(title: "Popular Product", subTitle: "View All"),
            FutureBuilder(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("error ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No products under this category"));
                } else {
                  final products = snapshot.data!;
                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductItemWidget(productModel: product);
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
