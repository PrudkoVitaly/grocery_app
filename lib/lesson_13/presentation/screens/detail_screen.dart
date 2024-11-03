import 'package:flutter/material.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/increase_product_quantity_use_case.dart';

import '../../data/data_source/product_data_source.dart';
import '../../data/repositories/cart_repositories_impl.dart';
import '../../data/repositories/product_repositories_impl.dart';
import '../../domain/useCase/add_to_cart_use_case.dart';
import '../../domain/useCase/get_current_product_use_case.dart';
import '../../domain/useCase/like_product_use_case.dart';
import 'cart_screen.dart';

class DetailScreen extends StatefulWidget {
  final ProductEntity product;

  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final AddToCartUseCase _addToCartUseCase;
  late final LikeProductUseCase _likeProductUseCase;

  @override
  void initState() {
    _addToCartUseCase =
        AddToCartUseCase(ProductRepositoriesImpl(ProductLocalDateSource()));

    _likeProductUseCase =
        LikeProductUseCase(ProductRepositoriesImpl(ProductLocalDateSource()));
    super.initState();
  }

  void addToCart(ProductEntity product) async {
    await _addToCartUseCase(product);
    setState(() {});
  }

  void like(ProductEntity product) async {
    await _likeProductUseCase(product);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFF2FFE6),
      ),
      body: Column(
        children: [
          Container(
            height: 360,
            width: double.infinity,
            color: Colors.white,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(170),
                      bottomRight: Radius.circular(170),
                    ),
                    child: Container(
                      height: 250,
                      decoration: const BoxDecoration(
                        color: Color(0XFFF2FFE6),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: Image.asset(
                      widget.product.image,
                      height: 250,
                      width: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          SingleChildScrollView(
            child: Container(
              height: 450,
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 16,
                top: 26,
                right: 16,
              ),
              decoration: const BoxDecoration(
                color: Color(0XFFF4F5F9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${widget.product.price}",
                        style: const TextStyle(
                          color: Color(0XFF28B446),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          like(widget.product);
                        },
                        icon: Icon(
                          widget.product.isLike
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.product.isLike
                              ? Colors.red
                              : const Color(0XFF868889),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.product.amount,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF868889),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        "4.5",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFF000000),
                        ),
                      ),
                      for (int i = 0; i < 5; i++)
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.star,
                              color: Color(0XFFFFC107), size: 20),
                        ),
                      Text(
                        "(${widget.product.reviews} reviews)",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0XFF868889),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      text: widget.product.description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF868889),
                        letterSpacing: 0.9,
                        wordSpacing: 2,
                      ),
                      children: const [
                        TextSpan(
                          text: " more",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "Quantity",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0XFF868889),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (widget.product.quantity > 1) {
                                widget.product.quantity--;
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Color(0XFF6CC51D),
                          ),
                        ),
                        const VerticalDivider(
                          color: Color(0XFFEBEBEB),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "${widget.product.quantity}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          color: Color(0XFFEBEBEB),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.product.quantity++;
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Color(0XFF6CC51D),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
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
                    onPressed: () {
                      addToCart(widget.product);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
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
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add to cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
