import 'dart:convert';

class CartModel {
  final String productName;
  final int productPrice;
  final String category;
  final List<String> image;
  final String vendorId;
  final int productQuantity;
  int quantity;
  final String productId;
  final String description;
  final String fullName;

  CartModel({
    required this.productName, 
    required this.productPrice, 
    required this.category, 
    required this.image, 
    required this.vendorId, 
    required this.productQuantity, 
    required this.quantity, 
    required this.productId, 
    required this.description, 
    required this.fullName
  });


  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productName: map['productName'],
      productPrice: map['productPrice'],
      category: map['category'],
      image: List<String>.from((map['image'] as List<dynamic>)),
      vendorId: map['vendorId'],
      productQuantity: map['productQuantity'],
      quantity: map['quantity'],
      productId: map['productId'],
      description: map['description'],
      fullName: map['fullName'],
    );
  }

  factory CartModel.fromJson(String source) => CartModel.fromMap(json.decode(source) as Map<String,dynamic>);

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      'category': category,
      'image': image,
      'vendorId': vendorId,
      'productQuantity': productQuantity,
      'quantity': quantity,
      'productId': productId,
      'description': description,
      'fullName': fullName,
    };
  }

  String toJson() => json.encode(toMap());
}