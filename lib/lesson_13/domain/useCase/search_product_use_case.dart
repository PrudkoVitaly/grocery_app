import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/repositories/product_repositories.dart';

class SearchProductUseCase {
  final ProductRepositories _productRepositories;

  SearchProductUseCase(this._productRepositories);

  Future<List<ProductEntity>> call (String name) async {
    return await _productRepositories.searchProducts(name);
  }
}