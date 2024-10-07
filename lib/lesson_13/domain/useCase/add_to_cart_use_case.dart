import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/repositories/product_repositories.dart';

class AddToCartUseCase {
  final ProductRepositories _productRepositories;

  AddToCartUseCase(this._productRepositories);

  Future<void> call(ProductEntity product) async {
    await _productRepositories.addToCart(product);
  }
}
