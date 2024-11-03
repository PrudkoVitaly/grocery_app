import 'package:flutter/material.dart';
import 'package:flutter_with_bay/lesson_13/data/data_source/product_data_source.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/cart_repositories_impl.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/product_repositories_impl.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/cart_use_case/remove_product_use_case.dart';
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
  List<ProductEntity>? _cartProducts;

  late final GetCartUseCase _getCartUseCase;
  late final IncreaseQuantityUseCase _increaseQuantityUseCase;
  late final DecreaseQuantityUseCase _decreaseQuantityUseCase;
  late final RemoveProductUseCase _removeProductUseCase;

  @override
  void initState() {
    _getCartUseCase = GetCartUseCase(CartRepositoriesImpl());
    getCartProducts();
    _increaseQuantityUseCase = IncreaseQuantityUseCase(CartRepositoriesImpl());
    _decreaseQuantityUseCase = DecreaseQuantityUseCase(CartRepositoriesImpl());
    _removeProductUseCase = RemoveProductUseCase(CartRepositoriesImpl());
    super.initState();
  }

  // Total price
  double _totalPrice = 10;

  void calculateTotalPrice() {
    _totalPrice = _cartProducts!.fold(
        0,
        (previousValue, element) =>
            previousValue + element.price * element.quantity);
    setState(() {});
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

  void removeProduct(ProductEntity product) async {
    await _removeProductUseCase(product);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart", style: TextStyle(fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 26),
              decoration: BoxDecoration(
                color: Color(0XFFF4F5F9),
              ),
              child: SafeArea(
                child: _cartProducts!.isEmpty
                    ? Expanded(
                  flex: 3,
                      child: Container(
                        width:  double.infinity,
                        child: Column(
                           mainAxisSize:  MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/shop_cart_empty.png"),
                            SizedBox(height: 36),
                            Text(
                              "Your cart is empty !",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              width: 200,
                              child: Text(
                                textAlign:  TextAlign.center,
                                "You will get a response within a few minutes.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0XFF868889),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    : Expanded(
                  flex: 1,
                      child: ListView.builder(
                          itemCount: _cartProducts!.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(_cartProducts![index].name),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child:
                                    const Icon(Icons.delete, color: Colors.white),
                              ),
                              onDismissed: (direction) {
                                removeProduct(_cartProducts![index]);
                              },
                              child: Container(
                                height: 100,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: ListTile(
                                    leading: Image.asset(
                                      _cartProducts![index].image,
                                      width: 70,
                                      alignment: Alignment.center,
                                    ),
                                    title: Text(
                                      _cartProducts![index].name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    subtitle: Text(
                                        "${_cartProducts![index].price * _cartProducts![index].quantity}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Color(0XFF868889))),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            decreaseQuantity(_cartProducts![index]);
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Color(0XFF6CC51D),
                                          ),
                                        ),
                                        Text(
                                          "${_cartProducts![index].quantity}",
                                          style: const TextStyle(
                                              color: Color(0XFF868889),
                                              fontSize: 16),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            increaseQuantity(_cartProducts![index]);
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Color(0XFF6CC51D),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                    ),
              ),
            ),
          ),

          _cartProducts!.isEmpty ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              elevation: 10,
              shadowColor: const Color(0XFF6CC51D).withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Ink(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFAEDC81),
                    Color(0XFF6CC51D),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Start shopping",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ) :
          Expanded(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 22, right: 22, top: 22, bottom: 36),
              color: Colors.white,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        "Subtotal",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFF868889),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$56.7",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFF868889),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Text(
                        "Shipping charges",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFF868889),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$1.6",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFF868889),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                    thickness: 1,
                    color: Color(0XFFEBEBEB),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF000000),
                        ),
                      ),
                      Spacer(),
                      // Total price
                      Text(
                        "\$58.2",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF000000),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Checkout button
                  _cartProducts!.isEmpty ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      elevation: 10,
                      shadowColor: const Color(0XFF6CC51D).withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Ink(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFAEDC81),
                            Color(0XFF6CC51D),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Start shopping",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ) :
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      elevation: 10,
                      shadowColor: const Color(0XFF6CC51D).withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Ink(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFAEDC81),
                            Color(0XFF6CC51D),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
