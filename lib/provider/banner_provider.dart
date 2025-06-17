import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/models/banner_model.dart';

class BannerProvider extends StateNotifier<List<BannerModel>> {
  BannerProvider() : super([]);

  void setBanner(List<BannerModel> banner){
    state = banner;
  }
}

final bannerProvider = StateNotifierProvider<BannerProvider,List<BannerModel>>(
  (ref) {
    return BannerProvider();
  }
);