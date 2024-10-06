import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/repositories/product_repositories.dart';

class FilterByCategoryUseCase {
  final ProductRepositories _productRepositories;

  FilterByCategoryUseCase(this._productRepositories);

  Future<List<ProductEntity>> call(String category) async {
    return await _productRepositories
        .filterProductsByCategory(category);
  }
}
