import 'package:flutter_with_bay/lesson_13/data/data_source/product_data_source.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/repositories/cart_repositories.dart';

class CartRepositoriesImpl implements CartRepositories {
  final ProductLocalDateSource _productLocalDateSource;

  CartRepositoriesImpl(this._productLocalDateSource);

  @override
  Future<List<ProductEntity>> getCartProducts() async {
    return await _productLocalDateSource.getCartProducts();
  }
}
