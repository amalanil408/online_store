
class ProductReviewModel {
  final String id;
  final String buyerId;
  final String email;
  final String fullName;
  final String productId;
  final double rating;
  final String review;

  ProductReviewModel({
    required this.id,
    required this.buyerId,
    required this.email,
    required this.fullName,
    required this.productId,
    required this.rating,
    required this.review,
  });

  factory ProductReviewModel.fromMap(Map<String, dynamic> map) {
    return ProductReviewModel(
      id: map['_id'] ?? '',
      buyerId: map['buyerId'] ?? '',
      email: map['email'] ?? '',
      fullName: map['fullName'] ?? '',
      productId: map['productId'] ?? '',
      rating: map['rating'] as double,
      review: map['review'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buyerId': buyerId,
      'email': email,
      'fullName': fullName,
      'productId': productId,
      'rating': rating,
      'review': review,
    };
  }

}
