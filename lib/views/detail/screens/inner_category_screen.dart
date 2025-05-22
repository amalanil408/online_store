import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_store/controllers/sub_category_controller.dart';
import 'package:online_store/core/widgets/common_widget.dart';
import 'package:online_store/models/category_model.dart';
import 'package:online_store/models/sub_category_model.dart';
import 'package:online_store/views/detail/screens/widgets/inner_banner_widget.dart';
import 'package:online_store/views/detail/screens/widgets/inner_header_widget.dart';
import 'package:online_store/views/detail/screens/widgets/sub_category_tile_widget.dart';

class InnerCategoryScreen extends StatefulWidget {
  final CategoryModel category;
  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  late Future<List<SubCategoriesModel>> _subCategories;
  final SubCategoryController _subCategoryController = SubCategoryController();

  @override
  void initState() {
    super.initState();
    _subCategories = _subCategoryController.getSubCategoriesByCategoryName(
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
                  return Center(child: Text("No Categories"));
                } else {
                  final subCategories = snapshot.data!;
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final subCategory = subCategories[index];
                      return SubCategoryTileWidget(
                        image: subCategory.image,
                        title: subCategory.subCategoryName,
                      );
                    },
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
