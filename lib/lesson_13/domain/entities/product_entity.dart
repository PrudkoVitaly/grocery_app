import 'dart:ui';

class ProductEntity {
  bool isLike;
  final String image;
  final double price;
  final String name;
  final String description;
  final int reviews;
  final String amount;
  final String category;
  final double? discount;
  final bool isNew;
  final bool isOnSale;
   bool showQuantity;
  final Color color;
  int quantity;

  ProductEntity({
    required this.image,
    required this.color,
    required this.price,
    required this.name,
    required this.description,
    required this.reviews,
    required this.amount,
    required this.category,
    this.showQuantity = false,
    this.isLike = false,
    this.isNew = false,
    this.isOnSale = false,
    this.discount,
    this.quantity = 1,
  });
}
