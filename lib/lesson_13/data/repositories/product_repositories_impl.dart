import 'package:flutter_with_bay/lesson_13/data/data_source/product_data_source.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/repositories/product_repositories.dart';

class ProductRepositoriesImpl implements ProductRepositories {
  final ProductDataSource _productDataSource;

  ProductRepositoriesImpl(this._productDataSource);

  @override
  Future<List<ProductEntity>> filterProductsByCategory(
      String category) async {
    final products = await _productDataSource.getProductFromDB();
    return products
        .where((product) => product.category == category)
        .toList();
  }

  @override
  Future<List<ProductEntity>> filterProductsByPrice(
      double minPrice, double maxPrice) async {
    final productsPrice = await _productDataSource.getProductFromDB();
    return productsPrice
        .where((product) =>
            product.price >= minPrice && product.price <= maxPrice)
        .toList();
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    return await _productDataSource.getProductFromDB();
  }

  @override
  Future<void> likeProduct(ProductEntity product) async {
    product.isLike = !product.isLike;
  }

  @override
  Future<List<ProductEntity>> searchProducts(String name) async {
    final productsName = await _productDataSource.getProductFromDB();
    return productsName
        .where((product) =>
            product.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  @override
  Future<void> addToCart(ProductEntity product) async {
    ProductEntity? existProduct;
    for(var item in cartProducts){
      if(item.name == product.name){
        existProduct = item;
        break;
      }
    }
      if(existProduct != null) {
        existProduct.quantity++;
      } else {
        cartProducts.add(product);
      }
  }

  @override
  Future<void> decreaseQuantity(ProductEntity product) {
    // TODO: implement decreaseQuantity
    throw UnimplementedError();
  }

  @override
  Future<void> increaseQuantity(ProductEntity product) async {
      final listProduct = await _productDataSource.getProductFromDB();
      final item = listProduct.firstWhere((item) => item.name == product.name);
      item.quantity++;
  }

  @override
  Future<ProductEntity> getCurrentProduct(ProductEntity product) async {
    final listProduct = await _productDataSource.getProductFromDB();
    return listProduct.firstWhere((item) => item.name == product.name);
  }

}
