import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_store/core/widgets/common_widget.dart';
import 'package:online_store/models/product_model.dart';
import 'package:online_store/provider/cart_provider.dart';
import 'package:online_store/provider/favorite_provider.dart';
import 'package:online_store/services/manage_http_response.dart';
import 'package:online_store/views/detail/screens/product_detail_screen.dart';

class ProductItemWidget extends ConsumerStatefulWidget {
  final ProductModel productModel;
  const ProductItemWidget({super.key, required this.productModel});

  @override
  ConsumerState<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends ConsumerState<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider.notifier);
    final favoriteProviderdata = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
    final cartData = ref.watch(cartProvider);
    final isInCart = cartData.containsKey(widget.productModel.id);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductDetailScreen(product: widget.productModel),
          ),
        );
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 160,
              width: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Image.network(
                    widget.productModel.images[0],
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: -5,
                    right: 2,
                    child: IconButton(
                      onPressed: () {
                        favoriteProviderdata.addProductsToFavorite(
                          productName: widget.productModel.productName,
                          productPrice: widget.productModel.productPrice,
                          category: widget.productModel.category,
                          image: widget.productModel.images,
                          vendorId: widget.productModel.vendorId,
                          productQuantity: widget.productModel.quantity,
                          quantity: 1,
                          productId: widget.productModel.id,
                          description: widget.productModel.description,
                          fullName: widget.productModel.fullName,
                        );
                        showSnackBar(
                          context,
                          "${widget.productModel.productName} added to wishlist",
                          Colors.green,
                        );
                      },
                      icon:
                          favoriteProviderdata.getFavoriteItems.containsKey(
                                widget.productModel.id,
                              )
                              ? Icon(Icons.favorite, color: Colors.red)
                              : Icon(Icons.favorite_border),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: isInCart ? null :
                      () {
                        cartProviderData.addProductToCart(
                      productName: widget.productModel.productName,
                      productPrice: widget.productModel.productPrice,
                      category: widget.productModel.category,
                      image: widget.productModel.images,
                      vendorId: widget.productModel.vendorId,
                      productQuantity: widget.productModel.quantity,
                      quantity: 1,
                      productId: widget.productModel.id,
                      description: widget.productModel.description,
                      fullName: widget.productModel.fullName,
                    );
                    showSnackBar(
                      context,
                      "${widget.productModel.productName} added",
                      Colors.green,
                    );
                      },
                      child: Image.asset(
                        'assets/icons/cart.png',
                        width: 26,
                        height: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.productModel.productName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            widget.productModel.averageRating == 0
                ? SizedBox()
                : Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    customSizedBox(width: 4),
                    Text(
                      widget.productModel.averageRating.toStringAsFixed(1),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
            customSizedBox(heigh: 4),
            Text(
              widget.productModel.category,
              style: GoogleFonts.quicksand(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xff868D94),
              ),
            ),
            Text(
              "\$${widget.productModel.productPrice.toStringAsFixed(2)}",
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
