import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.image,
    required super.price,
    required super.name,
    required super.amount,
    required super.category,
  });
}
