import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/controllers/product_controller.dart';
import 'package:online_store/provider/product_provider.dart';
import 'package:online_store/provider/top_rated_product_provider.dart';
import 'package:online_store/views/screens/nav_screens/widgets/product_item_widget.dart';

class TopRatedWidget extends ConsumerStatefulWidget {
  const TopRatedWidget({super.key});

  @override
  ConsumerState<TopRatedWidget> createState() =>
      _TopRatedWidgetState();
}

class _TopRatedWidgetState extends ConsumerState<TopRatedWidget> {
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
    final ProductController topRatedController = ProductController();
    try {
      final topRatedProduct = await topRatedController.loadTopRatedProduct();
      ref.read(topRatedProductProvider.notifier).setProducts(topRatedProduct);
    } catch (e) {
      throw Exception("Error fetching top rated product : $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(topRatedProductProvider);
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
