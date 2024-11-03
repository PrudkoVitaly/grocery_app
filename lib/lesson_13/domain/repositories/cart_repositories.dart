import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';

abstract class CartRepositories {
  Future<List<ProductEntity>> getCartProducts();

  Future<void> increaseQuantity(ProductEntity product);

  Future<void> decreaseQuantity(ProductEntity product);

  Future<void> removeProduct(ProductEntity product);
}
