import 'package:flutter_with_bay/lesson_13/domain/repositories/product_repositories.dart';

import '../../entities/product_entity.dart';
import '../../repositories/cart_repositories.dart';

class IncreaseQuantityUseCase {
  final CartRepositories _cartRepositories;

  IncreaseQuantityUseCase(this._cartRepositories);

  Future<void> call(ProductEntity product) async {
    await _cartRepositories.increaseQuantity(product);
  }
}