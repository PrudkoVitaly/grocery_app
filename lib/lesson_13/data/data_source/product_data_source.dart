import 'package:flutter_with_bay/lesson_13/data/models/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProductFromDB();
}

class ProductLocalDateSource implements ProductDataSource {
  @override
  Future<List<ProductModel>> getProductFromDB() async {
    return [
      ProductModel(
        image: "image",
        price: 8,
        name: "Fresh Peach",
        amount: "dozen",
        category: "Vegetables",
      ),
      ProductModel(
        image: "image",
        price: 7,
        name: "Avacoda",
        amount: "2",
        category: "Fruits",
      ),
      ProductModel(
        image: "image",
        price: 9.90,
        name: "Pineapple",
        amount: "1.50",
        category: "Fruits",
      ),
      ProductModel(
        image: "image",
        price: 3.00,
        name: "Fresh Broccoli",
        amount: "1",
        category: "Vegetables",
      ),
    ];
  }
}
