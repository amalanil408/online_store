import 'package:flutter/material.dart';
import 'package:online_store/controllers/product_controller.dart';
import 'package:online_store/core/widgets/common_widget.dart';
import 'package:online_store/models/product_model.dart';
import 'package:online_store/services/manage_http_response.dart';
import 'package:online_store/views/screens/nav_screens/widgets/product_item_widget.dart';

class SearchProductsScreen extends StatefulWidget {
  const SearchProductsScreen({super.key});

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ProductController productController = ProductController();
  List<ProductModel> _searchedProducts = [];

  bool isLoading = false;

  void _searchProducts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final query = _searchController.text.trim();
      if(query.isNotEmpty){
        final product = await productController.searchProducts(query);
        setState(() {
          _searchedProducts = product;
        });
      }
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : 4;
    final childAspectRatio = screenWidth < 600 ? 2 / 4 : 4 / 5;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: "Search Products ...",
            suffixIcon: IconButton(onPressed: (){
              _searchProducts();
            }, icon: Icon(Icons.search))
          ),
        ),
      ),
      body: Column(
        children: [
          customSizedBox(heigh: 16),
          if(isLoading)
          Center(child: CircularProgressIndicator(),)
          else if(_searchedProducts.isEmpty)
          Center(child: Text("No Products found"),)
          else
          Expanded(
            child: GridView.builder(
                itemCount: _searchedProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final product = _searchedProducts[index];
                  return ProductItemWidget(productModel: product);
                },
              ),
            )

        ],
      ),
    );
  }
}