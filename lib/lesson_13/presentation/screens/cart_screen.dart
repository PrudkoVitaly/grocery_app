import 'package:flutter/material.dart';
import 'package:flutter_with_bay/lesson_13/data/data_source/product_data_source.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/cart_repositories_impl.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/product_repositories_impl.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/get_cart_use_case.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final GetCartUseCase _getCartUseCase;

  @override
  void initState() {
    _getCartUseCase = GetCartUseCase(
        CartRepositoriesImpl(ProductLocalDateSource()));
    getCartProducts();
    // TODO: implement initState
    super.initState();
  }

  List<ProductEntity> _cartProducts = [];

  Future<void> getCartProducts() async {
    final cartProducts = await _getCartUseCase.call();
    setState(() {
      _cartProducts = cartProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _cartProducts.length,
                itemBuilder: (context, index) {
                  return Text(_cartProducts[index].name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
