import '../../entities/product_entity.dart';
import '../../repositories/cart_repositories.dart';

class DecreaseQuantityUseCase {
  final CartRepositories _cartRepositories;

  DecreaseQuantityUseCase(this._cartRepositories);

  Future<void> call(ProductEntity product) async {
    await _cartRepositories.decreaseQuantity(product);
  }
}