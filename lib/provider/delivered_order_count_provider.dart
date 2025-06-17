import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/controllers/order_controller.dart';
import 'package:online_store/services/manage_http_response.dart';

class DeliveredOrderCountProvider extends StateNotifier<int>{
  DeliveredOrderCountProvider() : super(0);

  Future<void> fetchDeliverCount(String buyerId,BuildContext context) async {
    try {
      OrderController orderController = OrderController();
      int count = await orderController.getDeliveredOrderCount(buyerId: buyerId, context: context);
      state = count;
    } catch (e) {
      showSnackBar(context, "Failed to load count $e", Colors.red);
    }
  }


  void resetCount(){
    state = 0;
  }
  
}

final deliveredOrderCountProvider = StateNotifierProvider<DeliveredOrderCountProvider,int>(
  (ref) {
    return DeliveredOrderCountProvider();
  }
);