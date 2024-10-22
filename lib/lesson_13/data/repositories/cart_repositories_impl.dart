import 'package:flutter_with_bay/lesson_13/data/data_source/product_data_source.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/repositories/cart_repositories.dart';

class CartRepositoriesImpl implements CartRepositories {


  @override
  Future<List<ProductEntity>> getCartProducts() async {
    return cartProducts;
  }

  @override
  Future<void> increaseQuantity(ProductEntity product) async {
    for(var item in cartProducts){
      if(item.name == product.name){
        item.quantity++;
        break;
      }
    }
  }

  @override
  Future<void> decreaseQuantity(ProductEntity product) async {
    for(var item in cartProducts){
      if(item.name == product.name){
        item.quantity--;
        break;
      }
    }
  }
}
