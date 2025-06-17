import 'package:flutter/material.dart';
import 'package:online_store/core/widgets/common_widget.dart';
import 'package:online_store/core/widgets/reusable_text_widget.dart';
import 'package:online_store/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:online_store/views/screens/nav_screens/widgets/category_item_widgets.dart';
import 'package:online_store/views/screens/nav_screens/widgets/header_widgets.dart';
import 'package:online_store/views/screens/nav_screens/widgets/popular_products_widget.dart';
import 'package:online_store/views/screens/nav_screens/widgets/top_rated_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.20), 
        child: HeaderWidgets(),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 0,),
              BannerWidget(),
              SizedBox(height: 5,),
              CategoryItemWidgets(),
              ReusableTextWidget(title: "Top Rated Product", subTitle: "View All"),
              TopRatedWidget(),
              ReusableTextWidget(title: "Popular Products", subTitle: 'View All'),
              customSizedBox(heigh: 5),
              PopularProductsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}