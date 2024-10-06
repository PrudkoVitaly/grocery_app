import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';

abstract class ProductRepositories {
  Future<List<ProductEntity>> getProducts();

  Future<List<ProductEntity>> searchProducts(String name);

  Future<List<ProductEntity>> filterProductsByPrice(
      double minPrice, double maxPrice);

  Future<List<ProductEntity>> filterProductsByCategory(
      String category);

  Future<void> likeProduct(ProductEntity product);
}
