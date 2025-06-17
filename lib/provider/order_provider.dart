import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/models/order_model.dart';

class OrderProvider extends StateNotifier<List<OrderModel>> {
  OrderProvider() : super([]);


  void setOrders(List<OrderModel> orders){
    state = orders;
  }

}

final orderProvider = StateNotifierProvider<OrderProvider,List<OrderModel>>(
  (ref) {
    return OrderProvider();
  }
);