import 'dart:ui';

import 'package:flutter_with_bay/lesson_13/data/models/product_model.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProductFromDB();
}

class ProductLocalDateSource implements ProductDataSource {
  @override
  Future<List<ProductModel>> getProductFromDB() async {
    return [
      ProductModel(
        image: "assets/peach.png",
        color: Color(0XFFFFCEC1),
        price: 8,
        name: "Fresh Peach",
        description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. Organic lemons are considered to be the world's finest lemon for juicing",
        reviews: 79,
        amount: "dozen",
        category: "Fruits",
        isNew: false,
        isOnSale: false,
      ),
      ProductModel(
        image: "assets/avocado.png",
        color: Color(0XFFFCFFD9),
        price: 7,
        name: "Avocado",
        description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. Organic lemons are considered to be the world's finest lemon for juicing",
        reviews: 55,
        amount: "2",
        category: "Fruits",
        isNew: true,
        isOnSale: false,
      ),
      ProductModel(
        image: "assets/pineapple.png",
        color: Color(0XFFFFE6C2),
        price: 9.90,
        name: "Pineapple",
        description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. Organic lemons are considered to be the world's finest lemon for juicing",
        reviews: 10,
        amount: "1.50",
        category: "Fruits",
        isNew: false,
        isOnSale: false,
      ),
      ProductModel(
        image: "assets/grapes.png",
        color: Color(0XFFFEE1ED),
        price: 7.05,
        name: "Black Grapes",
        description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. Organic lemons are considered to be the world's finest lemon for juicing",
        reviews: 93,
        amount: "5.00",
        category: "Fruits",
        isNew: false,
        isOnSale: true,
        discount: -16,
      ),
      ProductModel(
        image: "assets/pomegranate.png",
        color: Color(0XFFFFE3E2),
        price: 2.09,
        name: "Pomegranate",
        description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. Organic lemons are considered to be the world's finest lemon for juicing",
        reviews: 44,
        amount: "1.50",
        category: "Fruits",
        isNew: true,
        isOnSale: false,
      ),
      ProductModel(
        image: "assets/broccoli.png",
        color: Color(0XFFFD2FFD0),
        price: 3.00,
        name: "Pomegranate",
        description: "Organic Mountain works as a seller for many organic growers of organic lemons. Organic lemons are easy to spot in your produce aisle. They are just like regular lemons, but they will usually have a few more scars on the outside of the lemon skin. Organic lemons are considered to be the world's finest lemon for juicing",
        reviews: 39,
        amount: "1.00",
        category: "Vegetables",
        isNew: false,
        isOnSale: false,
      ),
    ];
  }
}

List<ProductEntity> cartProducts = [];
