

class OrderModel {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String productName;
  final int productPrice;
  final int quantity;
  final String category;
  final String image;
  final String buyerId;
  final String vendorId;
  final String productId;
  final bool processing;
  final bool delivered;

  OrderModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.category,
    required this.image,
    required this.buyerId,
    required this.vendorId,
    required this.productId,
    required this.processing,
    required this.delivered,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      locality: json['locality'] as String,
      productName: json['productName'] as String,
      productPrice: json['productPrice'] as int,
      quantity: json['quantity'] as int,
      category: json['category'] as String,
      image: json['image'] as String,
      buyerId: json['buyerId'] as String,
      vendorId: json['vendorId'] as String,
      productId: json['productId'] as String,
      processing: json['processing'] as bool,
      delivered: json['delivered'] as bool,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'category': category,
      'image': image,
      'buyerId': buyerId,
      'vendorId': vendorId,
      'productId' : productId,
      'proccessing': processing,
      'delivered': delivered,
    };
  }

  Map<String,dynamic> toJson() => toMap();
}
