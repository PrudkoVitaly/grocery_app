import 'package:flutter/material.dart';
import 'package:flutter_with_bay/lesson_13/data/data_source/product_data_source.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/product_repositories_impl.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/filtred_by_category_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/get_products_use_case.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final GetProductsUseCase _getProductsUseCase;

  List<ProductEntity> filterProducts = [];

  @override
  void initState() {
    _getProductsUseCase = GetProductsUseCase(
        ProductRepositoriesImpl(ProductLocalDateSource()));
    getProducts();
    super.initState();
  }

  Future<void> getProducts() async {
    final products = await _getProductsUseCase();
    setState(() {
      filterProducts = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: filterProducts.length,
        itemBuilder: (context, index) {
          final product = filterProducts[index];
          return ListTile(
            title: Text(product.name),
          );
        },
      ),
    );
  }
}
