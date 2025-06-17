import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_store/core/themes/colors.dart';
import 'package:online_store/provider/favorite_provider.dart';
import 'package:online_store/views/screens/main_screen.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final wishListItemData = ref.watch(favoriteProvider);
    final wishListProvider = ref.read(favoriteProvider.notifier);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.20,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/cartb.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 322,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset('assets/icons/not.png', width: 25, height: 25),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade800,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            wishListItemData.length.toString(),
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 61,
                top: 51,
                child: Text(
                  "My Cart",
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: wishListItemData.isEmpty ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                "Your wishlist  is empty\n you can add products to wishlist from the button below",style: GoogleFonts.roboto(
                fontSize: 15,
                letterSpacing: 1.7,
              ),),
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MainScreen()));
              }, child: Text("Shop Now"))
            ],
          ),
        ) :  ListView.builder(
        itemCount: wishListItemData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final wishData = wishListItemData.values.toList()[0];
          return Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Container(
                width: 335,
                height: 96,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 336,
                          height: 97,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(color: Color(0xFFEFF0F2)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        top: 9,
                        child: Container(
                          width: 78,
                          height: 78,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Color(0xFFBCC5FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 270,
                        top: 10,
                        child: Text(
                          '\$${wishData.productPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 101,
                        top: 14,
                        child: SizedBox(
                          width: 162,
                          child: Text(
                            wishData.productName,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 23,
                        top: 14,
                        child: Image.network(
                          wishData.image[0],
                          width: 56,
                          height: 67,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 284,
                        top: 47,
                        child: IconButton(onPressed: (){
                          wishListProvider.removeFavoriteItem(wishData.productId);
                        }, icon: Icon(Icons.delete,color: Colors.red,)))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
