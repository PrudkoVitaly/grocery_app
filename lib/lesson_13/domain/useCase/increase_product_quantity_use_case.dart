import '../entities/product_entity.dart';
import '../repositories/product_repositories.dart';

class IncreaseProductQuantityUseCase {
  final ProductRepositories _productRepositories;

  IncreaseProductQuantityUseCase(this._productRepositories);

  Future<void> call(ProductEntity product) async {
    await _productRepositories.increaseQuantity(product);
  }
}