import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/repositories/product_repositories.dart';

class LikeProductUseCase {
  final ProductRepositories _productRepositories;

  LikeProductUseCase(this._productRepositories);

  Future<void> call(ProductEntity product) async {
    return await _productRepositories.likeProduct(product);
  }
}
