import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_bay/lesson_02/lesson_02.dart';
import 'package:flutter_with_bay/lesson_09/lesson_09.dart';
import 'package:flutter_with_bay/lesson_13/data/data_source/product_data_source.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/product_repositories_impl.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/add_to_cart_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/filtred_by_category_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/filtred_product_by_price.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/get_products_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/like_product_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/search_product_use_case.dart';
import 'package:flutter_with_bay/lesson_13/presentation/screens/cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final GetProductsUseCase _getProductsUseCase;
  late final SearchProductUseCase _searchProductUseCase;
  late final FilteredProductByPrice _filteredProductByPrice;
  late final FilterByCategoryUseCase _filtredByCategoryUseCase;
  late final LikeProductUseCase _likeProductUseCase;
  late final AddToCartUseCase _addToCartUseCase;

  List<ProductEntity> filterProducts = [];
  List<ProductEntity> _products = [];
  String searchText = '';
  double minPrice = 0;
  double maxPrice = double.infinity;
  String selectedCategory = 'All';

  @override
  void initState() {
    _getProductsUseCase = GetProductsUseCase(
        ProductRepositoriesImpl(ProductLocalDateSource()));
    getProducts();

    _searchProductUseCase = SearchProductUseCase(
        ProductRepositoriesImpl(ProductLocalDateSource()));

    _filteredProductByPrice = FilteredProductByPrice(
        ProductRepositoriesImpl(ProductLocalDateSource()));

    _filtredByCategoryUseCase = FilterByCategoryUseCase(
        ProductRepositoriesImpl(ProductLocalDateSource()));

    _likeProductUseCase = LikeProductUseCase(
        ProductRepositoriesImpl(ProductLocalDateSource()));

    _addToCartUseCase = AddToCartUseCase(
        ProductRepositoriesImpl(ProductLocalDateSource()));

    super.initState();
  }

  Future<void> getProducts() async {
    final products = await _getProductsUseCase();
    setState(() {
      _products = products;
      filterProducts = products;
    });
  }

  void searchProduct(String value) async {
    final result = await _searchProductUseCase(value);
    setState(() {
      filterProducts = result;
    });
  }

  void filterByCategory(String category) async {
    final result = category == 'All'
        ? _products
        : await _filtredByCategoryUseCase(category);
    setState(() {
      filterProducts = result;
      selectedCategory = category;
    });
  }

  void like(ProductEntity product) async {
    await _likeProductUseCase(product);
    setState(() {});
  }

  void filerByPrice(double minPrice, double maxPrice) async {
    final result = await _filteredProductByPrice(minPrice, maxPrice);
    setState(() {
      filterProducts = result;
    });
  }

  void addToCart(ProductEntity product) async {
    await _addToCartUseCase.call(product);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Added to cart"),
      ),
    );
  }

  void showFilter() {
    double _minPrice = minPrice;
    double _maxPrice = maxPrice;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Filter by price"),
            content: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      minPrice = double.tryParse(value) ?? _minPrice;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Min price',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      maxPrice = double.tryParse(value) ?? _maxPrice;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Max price',
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _minPrice = minPrice;
                    _maxPrice = maxPrice;
                  });
                  filerByPrice(_minPrice, _maxPrice);
                  Navigator.pop(context);
                },
                child: const Text("Filter"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFEFEFEF),
              Color(0xFFD5D5D5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: searchProduct,
                        decoration: const InputDecoration(
                          hintText: 'Search keyword',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showFilter();
                      },
                      icon: const Icon(Icons.tune),
                    ),
                  ],
                ),
                Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        "All",
                        "Vegetables",
                        "Fruits",
                      ].map((category) {
                        return GestureDetector(
                          onTap: () {
                            filterByCategory(category);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 4),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(16),
                                color: selectedCategory == category
                                    ? Colors.blue
                                    : Colors.transparent),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16),
                                child: Center(child: Text(category))),
                          ),
                        );
                      }).toList(),
                    )),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.9,
                      mainAxisExtent: 234,
                    ),
                    itemCount: filterProducts.length,
                    itemBuilder: (context, index) {
                      final product = filterProducts[index];
                      return Stack(
                        children: [
                          Container(
                            width: 181,
                            height: 234,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(product.image),
                                Text(product.price.toString()),
                                Text(product.name),
                                Text(product.amount),
                                const Spacer(),
                                const Divider(),
                                // Кнопка "Добавить в корзину"
                                TextButton(
                                  onPressed: () {
                                    addToCart(product);
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.shopping_cart),
                                      Text("Add to cart"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (product.isNew)
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                height: 18,
                                width: 38,
                                decoration: const BoxDecoration(
                                  color: Color(0XFFFDEFD5),
                                ),
                                child: const Text(
                                  textAlign: TextAlign.center,
                                  'NEW',
                                  style: TextStyle(
                                    color: Color(0XFFE8AD41),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          // Отметка скидки
                          if (product.isOnSale)
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                height: 18,
                                width: 38,
                                decoration: const BoxDecoration(
                                  color: Color(0XFFFEE4E4),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  '-${product.discount!.toInt()}%',
                                  style: const TextStyle(
                                    color: Color(0XFFF56262),
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            top: -10,
                            right: -10,
                            child: IconButton(
                              onPressed: () {
                                like(product);
                              },
                              icon: Icon(
                                product.isLike
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: product.isLike
                                    ? Colors.red
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
