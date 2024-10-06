import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/repositories/product_repositories.dart';

class FilteredProductByPrice {
  final ProductRepositories _productRepositories;

  FilteredProductByPrice(this._productRepositories);

  Future<List<ProductEntity>> call (double minPrice, double maxPrice) async {
    return await _productRepositories.filterProductsByPrice(minPrice, maxPrice);
  }
}