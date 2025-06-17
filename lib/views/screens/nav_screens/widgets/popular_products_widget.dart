import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/controllers/product_controller.dart';
import 'package:online_store/provider/product_provider.dart';
import 'package:online_store/views/screens/nav_screens/widgets/product_item_widget.dart';

class PopularProductsWidget extends ConsumerStatefulWidget {
  const PopularProductsWidget({super.key});

  @override
  ConsumerState<PopularProductsWidget> createState() =>
      _PopularProductsWidgetState();
}

class _PopularProductsWidgetState extends ConsumerState<PopularProductsWidget> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    final products = ref.read(productProvider);
    if(products.isEmpty){
      _fetchProduct();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();
    try {
      final product = await productController.loadPopularProducts();
      ref.read(productProvider.notifier).setProducts(product);
    } catch (e) {
      throw Exception("Error fetching orders : $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    return SizedBox(
      height: 250,
      child: isLoading ? Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ) : ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductItemWidget(productModel: product);
        },
      ),
    );
  }
}
