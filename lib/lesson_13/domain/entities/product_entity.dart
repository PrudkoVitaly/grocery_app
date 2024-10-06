class ProductEntity {
  bool isLike;
  final String image;
  final double price;
  final String name;
  final String amount;
  final String category;

  ProductEntity({
    required this.image,
    required this.price,
    required this.name,
    required this.amount,
    required this.category,
    this.isLike = false,
  });
}
