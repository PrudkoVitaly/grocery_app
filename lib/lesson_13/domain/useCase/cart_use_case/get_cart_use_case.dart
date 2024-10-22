import '../../entities/product_entity.dart';
import '../../repositories/cart_repositories.dart';

class GetCartUseCase {
  final CartRepositories _cartRepositories;

  GetCartUseCase(this._cartRepositories);

  Future<List<ProductEntity>> call() async {
    return await _cartRepositories.getCartProducts();
  }
}