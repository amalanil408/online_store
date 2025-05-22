import 'package:flutter/material.dart';
import 'package:online_store/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:online_store/views/screens/nav_screens/widgets/category_item_widgets.dart';
import 'package:online_store/views/screens/nav_screens/widgets/header_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidgets(),
              SizedBox(height: 0,),
              BannerWidget(),
              SizedBox(height: 5,),
              CategoryItemWidgets()
            ],
          ),
        ),
      ),
    );
  }
}