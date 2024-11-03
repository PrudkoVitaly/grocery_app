import '../entities/product_entity.dart';
import '../repositories/product_repositories.dart';

class GetCurrentProductUseCase {

  final ProductRepositories _productRepositories;

  GetCurrentProductUseCase(this._productRepositories);

  Future<ProductEntity> call(ProductEntity product) async {
    return await _productRepositories.getCurrentProduct(product);
  }
}