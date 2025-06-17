import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_store/global_variables.dart';
import 'package:online_store/models/product_review_model.dart';
import 'package:http/http.dart' as http;
import 'package:online_store/services/manage_http_response.dart';
class ProductReviewController {
  uploadReview({
    required String buyerId,
    required String email,
    required String fullName,
    required String productId,
    required double rating,
    required String review,
    required context
  }) async {
    try {
      final ProductReviewModel productReviewModel = ProductReviewModel(
        id: '',
        buyerId: buyerId,
        email: email,
        fullName: fullName,
        productId: productId,
        rating: rating,
        review: review,
      );
      http.Response response =  await http.post(Uri.parse("$uri/api/product-review"),
      body: jsonEncode(productReviewModel.toMap()),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8'
      }
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackBar(context, "Review Added", Colors.green);
      });
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }
}
