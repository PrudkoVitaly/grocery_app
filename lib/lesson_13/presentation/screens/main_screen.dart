import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_with_bay/lesson_13/data/data_source/product_data_source.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/product_repositories_impl.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/filtred_by_category_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/filtred_product_by_price.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/get_products_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/like_product_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/search_product_use_case.dart';

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

  void showFilter() {
    double _minPrice = minPrice;
    double _maxPrice = maxPrice;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Filter by price"),
            content: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      minPrice = double.tryParse(value) ?? _minPrice;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
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
                    decoration: InputDecoration(
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
      body: SafeArea(
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
                              borderRadius: BorderRadius.circular(16),
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
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: filterProducts.length,
                  itemBuilder: (context, index) {
                    final product = filterProducts[index];
                    return Container(
                      width: 181,
                      height: 234,
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Text(product.name),
                    );
                  },
                ),
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: filterProducts.length,
              //     itemBuilder: (context, index) {
              //       final product = filterProducts[index];
              //       return ListTile(
              //         title: Text(product.name),
              //         subtitle: Text(product.price.toString()),
              //         trailing: IconButton(
              //           onPressed: () {
              //             like(product);
              //           },
              //           icon: product.isLike
              //               ? const Icon(Icons.favorite,
              //                   color: Colors.red)
              //               : const Icon(Icons.favorite_border),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
