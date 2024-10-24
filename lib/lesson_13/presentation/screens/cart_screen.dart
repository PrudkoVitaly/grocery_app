import 'package:flutter/material.dart';
import 'package:flutter_with_bay/lesson_13/data/data_source/product_data_source.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/cart_repositories_impl.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/product_repositories_impl.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/get_cart_use_case.dart';

import '../../domain/useCase/cart_use_case/decrease_quantity_use_case.dart';
import '../../domain/useCase/cart_use_case/get_cart_use_case.dart';
import '../../domain/useCase/cart_use_case/increment_quantity_use_case.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ProductEntity> _cartProducts = [];

  late final GetCartUseCase _getCartUseCase;
  late final IncreaseQuantityUseCase _increaseQuantityUseCase;
  late final DecreaseQuantityUseCase _decreaseQuantityUseCase;

  @override
  void initState() {
    _getCartUseCase = GetCartUseCase(CartRepositoriesImpl());
    getCartProducts();
    _increaseQuantityUseCase = IncreaseQuantityUseCase(CartRepositoriesImpl());
    _decreaseQuantityUseCase = DecreaseQuantityUseCase(CartRepositoriesImpl());
    super.initState();
  }

  Future<void> getCartProducts() async {
    final cartProducts = await _getCartUseCase.call();
    setState(() {
      _cartProducts = cartProducts;
    });
  }

  void increaseQuantity(ProductEntity product) async {
    await _increaseQuantityUseCase(product);
    setState(() {});
  }

  void decreaseQuantity(ProductEntity product) async {
    await _decreaseQuantityUseCase(product);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _cartProducts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_cartProducts[index].name),
                      subtitle: Text(
                          "${_cartProducts[index].price * _cartProducts[index].quantity}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              decreaseQuantity(_cartProducts[index]);
                            },
                            icon: const Icon(
                              Icons.remove,
                            ),
                          ),
                          Text("${_cartProducts[index].quantity}"),
                          IconButton(
                            onPressed: () {
                              increaseQuantity(_cartProducts[index]);
                            },
                            icon: const Icon(
                              Icons.add,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
