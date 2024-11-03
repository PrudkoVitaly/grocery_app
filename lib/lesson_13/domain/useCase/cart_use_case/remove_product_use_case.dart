import 'package:flutter_with_bay/lesson_13/domain/repositories/cart_repositories.dart';

import '../../entities/product_entity.dart';

class RemoveProductUseCase {
  final CartRepositories _cartRepositories;

  RemoveProductUseCase(this._cartRepositories);

  Future<void> call(ProductEntity product) async {
    await _cartRepositories.removeProduct(product);
  }
}