import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_store/global_variables.dart';
import 'package:online_store/models/order_model.dart';
import 'package:online_store/services/manage_http_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController {
  uploadOrder({
    required String id,
    required String fullName,
    required String email,
    required String state,
    required String city,
    required String locality,
    required String productName,
    required int productPrice,
    required int quantity,
    required String category,
    required String image,
    required String buyerId,
    required String vendorId,
    required String productId,
    required bool processing,
    required bool delivered,
    required context
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("auth_token");
      final OrderModel orderModel = OrderModel(
        id: id,
        fullName: fullName,
        email: email,
        state: state,
        city: city,
        locality: locality,
        productName: productName,
        productPrice: productPrice,
        quantity: quantity,
        category: category,
        image: image,
        buyerId: buyerId,
        vendorId: vendorId,
        productId: productId,
        processing: processing,
        delivered: delivered,
      );
      http.Response response =  await http.post(Uri.parse("$uri/api/orders"),
      body: jsonEncode(orderModel.toJson()),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8',
        'x-auth-token' : token!,
      }
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackBar(context, "Ordered Successfully", Colors.green);
      });
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }



  Future<List<OrderModel>> loadOrder({required String buyerId,required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("auth_token");


      http.Response response =  await http.get(Uri.parse('$uri/api/orders/$buyerId'),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8',
        'x-auth-token' : token!,
      }
      );
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<OrderModel> orders = data.map((order) => OrderModel.fromJson(order)).toList();
        return orders;
      } 
      else if(response.statusCode == 404){
        return [];
      }
      else{
        showSnackBar(context, "Failed to load data", Colors.red);
        return [];
      }
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
      return [];
    }
  }


  Future<void> deletedOrder({required String id,required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("auth_token");
      http.Response response = await http.delete(Uri.parse('$uri/api/orders/$id'),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8',
        'x-auth-token' : token!,
      }
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackBar(context, "Order Deleted Successfull", Colors.red);
      });
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }


  Future<int> getDeliveredOrderCount({required String buyerId,required context}) async {
    try {
      List<OrderModel> orders =  await loadOrder(buyerId: buyerId, context: context);
      int deliveredCount = orders.where((order) => order.delivered).length;
      return deliveredCount;
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
      return 0;
    }
  }
}
