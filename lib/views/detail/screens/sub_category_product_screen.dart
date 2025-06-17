import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/controllers/product_controller.dart';
import 'package:online_store/models/sub_category_model.dart';
import 'package:online_store/provider/sub_category_products_provider.dart';
import 'package:online_store/views/screens/nav_screens/widgets/product_item_widget.dart';

class SubCategoryProductScreen extends ConsumerStatefulWidget {
  final SubCategoriesModel subCategory;
  const SubCategoryProductScreen({super.key, required this.subCategory});

  @override
  ConsumerState<SubCategoryProductScreen> createState() =>
      _SubCategoryProductScreenState();
}

class _SubCategoryProductScreenState
    extends ConsumerState<SubCategoryProductScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    final productController = ProductController();
    try {
      final products = await productController
          .loadProductBySubcategory(widget.subCategory.subCategoryName);
      ref
          .read(subCategoryProductsProvider(widget.subCategory.subCategoryName).notifier)
          .setProducts(products);
    } catch (e) {
      throw Exception("Error fetching products: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final products =
        ref.watch(subCategoryProductsProvider(widget.subCategory.subCategoryName));

    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : 4;
    final childAspectRatio = screenWidth < 600 ? 2 / 4 : 4 / 5;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subCategory.subCategoryName),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductItemWidget(productModel: product);
                },
              ),
            ),
    );
  }
}
