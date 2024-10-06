import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/repositories/product_repositories.dart';

class GetProductsUseCase {
  final ProductRepositories _productRepositories;

  GetProductsUseCase(this._productRepositories);

  Future<List<ProductEntity>> call () async {
    return await _productRepositories.getProducts();
  }
}