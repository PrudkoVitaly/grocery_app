import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_bay/lesson_13/data/data_source/product_data_source.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/category_repository_impl.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/product_repositories_impl.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/category_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/filtred_by_category_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/filtred_product_by_price.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/get_products_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/like_product_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/search_product_use_case.dart';

import '../../data/data_source/category_data_source.dart';
import '../../domain/useCase/category_use_case/get_categories_use_case.dart';

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

  // Category
  late final GetCategoriesUseCase _getCategoriesUseCase;

  List<ProductEntity> filterProducts = [];
  List<ProductEntity> _products = [];
  String searchText = '';
  double minPrice = 0;
  double maxPrice = double.infinity;
  String selectedCategory = 'All';

  dynamic _categories = [];

  @override
  void initState() {
    _getProductsUseCase =
        GetProductsUseCase(ProductRepositoriesImpl(ProductLocalDateSource()));
    getProducts();

    _searchProductUseCase =
        SearchProductUseCase(ProductRepositoriesImpl(ProductLocalDateSource()));

    _filteredProductByPrice = FilteredProductByPrice(
        ProductRepositoriesImpl(ProductLocalDateSource()));

    _filtredByCategoryUseCase = FilterByCategoryUseCase(
        ProductRepositoriesImpl(ProductLocalDateSource()));

    _likeProductUseCase =
        LikeProductUseCase(ProductRepositoriesImpl(ProductLocalDateSource()));

    _getCategoriesUseCase =
        GetCategoriesUseCase(CategoryRepositoryImpl(CategoryLocalDataSource()));

    super.initState();
  }

  Future<void> getCategories() async {
    final categories = await _getCategoriesUseCase;
    setState(() {
      _categories = categories;
    });
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0XFFFFFFFF),
              Colors.grey[200]!,
              Colors.grey[400]!,
              // Color(0XFFF4F5F9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: searchProduct,
                        decoration: InputDecoration(
                          hintText: 'Search keyword',
                          hintStyle: const TextStyle(
                            color: Color(0XFF868889),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0XFF868889),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              showFilter();
                            },
                            icon: const Icon(
                              Icons.tune,
                              color: Color(0XFF868889),
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: const Color(0XFFF4F5F9),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 21),

                // Categories
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF000000),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];

                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: selectedCategory == category
                                ? const Color(0XFFD9D9D9)
                                : Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6),
                            ),
                            border: Border.all(
                              color: const Color(0XFFD9D9D9),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: selectedCategory == category
                                  ? const Color(0XFF000000)
                                  : const Color(0XFF868889),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Products
                const Text(
                  "Featured products",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF000000),
                  ),
                ),
                const SizedBox(height: 21),
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 18,
                        crossAxisSpacing: 18,
                        mainAxisExtent: 234,
                        childAspectRatio: 0.1,
                      ),
                      itemCount: filterProducts.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              // width: 191,
                              // height: 234,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 16),
                                  Container(
                                    width: 84,
                                    height: 84,
                                    decoration: BoxDecoration(
                                      color: filterProducts[index].color,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          top: 20,
                                          child: Image.asset(
                                            filterProducts[index].image,
                                            width: 84,
                                            height: 84,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 26),
                                  Text(
                                    " \$${filterProducts[index].price.toString()}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0XFF6CC51D),
                                    ),
                                  ),
                                  Text(
                                    filterProducts[index].name,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    filterProducts[index].amount,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  const Spacer(),
                                  const Divider(
                                    height: 0,
                                    color: Color(0XFFEBEBEB),
                                  ),
                                  SizedBox(
                                    height: 41,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/icon_add_cart.png",
                                            scale: 0.8,
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "Add to cart",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0XFF010101),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            filterProducts[index].isNew
                                ? Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 38,
                                      height: 18,
                                      color: const Color(0xFFFDEFD5),
                                      child: const Center(
                                        child: Text(
                                          "New",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFE8AD41),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.transparent,
                                  ),
                            filterProducts[index].isOnSale
                                ? Positioned(
                                    left: 13.5,
                                    top: 0,
                                    child: Container(
                                      width: 38,
                                      height: 18,
                                      color: const Color(0XFFFEE4E4),
                                      child: Center(
                                        child: Text(
                                          filterProducts[index].discount! == 0
                                              ? filterProducts[index]
                                                  .price
                                                  .toStringAsFixed(0)
                                              : "${filterProducts[index].discount!.toStringAsFixed(0)}%",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0XffF56262),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.transparent,
                                  ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                onPressed: () {
                                  like(filterProducts[index]);
                                },
                                icon: filterProducts[index].isLike
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Color(0XFFFE585A),
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                        color: Color(0XFF868889),
                                      ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
