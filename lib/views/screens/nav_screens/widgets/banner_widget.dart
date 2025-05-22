import 'package:flutter/material.dart';
import 'package:online_store/controllers/banner_controller.dart';
import 'package:online_store/models/banner_model.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futureBanners;
  final BannerController _bannerController = BannerController();

  @override
  void initState() {
    super.initState();
    futureBanners = _bannerController.loadbanners();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Color(0xFFF7F7F7),
        ),
        child: FutureBuilder(
          future: futureBanners,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No Banners"));
            } else {
              final banners = snapshot.data!;
              return PageView.builder(
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  final banner = banners[index];
                  return Image.network(banner.image,fit: BoxFit.cover,);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
