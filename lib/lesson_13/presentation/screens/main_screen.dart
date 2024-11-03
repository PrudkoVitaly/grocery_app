import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_bay/lesson_13/data/data_source/product_data_source.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/cart_repositories_impl.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/category_repository_impl.dart';
import 'package:flutter_with_bay/lesson_13/data/repositories/product_repositories_impl.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/category_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/entities/product_entity.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/add_to_cart_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/cart_use_case/increment_quantity_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/filtred_by_category_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/filtred_product_by_price.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/get_products_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/like_product_use_case.dart';
import 'package:flutter_with_bay/lesson_13/domain/useCase/search_product_use_case.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/data_source/category_data_source.dart';
import '../../domain/useCase/cart_use_case/decrease_quantity_use_case.dart';
import '../../domain/useCase/category_use_case/get_categories_use_case.dart';
import 'cart_screen.dart';
import 'detail_screen.dart';

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
  late final DecreaseQuantityUseCase _decreaseQuantityUseCase;
  late final IncreaseQuantityUseCase _increaseQuantityUseCase;

  // Category
  late final GetCategoriesUseCase _getCategoriesUseCase;

  List<ProductEntity> filterProducts = [];
  List<ProductEntity> _products = [];
  String searchText = '';
  double minPrice = 0;
  double maxPrice = double.infinity;
  String selectedCategory = 'All';
  bool showQuantity = false;

  List<CategoryEntity> _categories = [];

  // Smooth Page Indicator
  PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

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
    getCategories();

    _addToCartUseCase =
        AddToCartUseCase(ProductRepositoriesImpl(ProductLocalDateSource()));

    _decreaseQuantityUseCase = DecreaseQuantityUseCase(
      CartRepositoriesImpl(),
    );

    _increaseQuantityUseCase = IncreaseQuantityUseCase(
      CartRepositoriesImpl(),
    );

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });

    _startAutoScroll();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void decreaseQuantity(ProductEntity product) async {
    await _decreaseQuantityUseCase(product);
    setState(() {});
  }

  void increaseQuantity(ProductEntity product) async {
    await _increaseQuantityUseCase(product);
    setState(() {});
  }

  Future<void> getCategories() async {
    final categories = await _getCategoriesUseCase();
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

  void addToCart(ProductEntity product) async {
    await _addToCartUseCase(product);
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added to cart'),
        ),
      );
      product.showQuantity = !product.showQuantity;
    });
  }

  // Smooth Page Indicator Auto Scroll
  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
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
    return Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),
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

              // Page View
              Container(
                height: 283,
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          PageView(
                            controller: _pageController,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        Image.asset("assets/slider_image_1.png")
                                            .image,
                                  ),
                                ),
                                child: const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 80,
                                      left: 44,
                                    ),
                                    child: Text(
                                      "20% off on your \n first purchase",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        Image.asset("assets/slider_image_1.png")
                                            .image,
                                  ),
                                ),
                                child: const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 80,
                                      left: 44,
                                    ),
                                    child: Text(
                                      "30% off on your \n first purchase",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        Image.asset("assets/slider_image_1.png")
                                            .image,
                                  ),
                                ),
                                child: const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 80,
                                      left: 44,
                                    ),
                                    child: Text(
                                      "40% off on your \n first purchase",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        Image.asset("assets/slider_image_1.png")
                                            .image,
                                  ),
                                ),
                                child: const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 80,
                                      left: 44,
                                    ),
                                    child: Text(
                                      "50% off on your \n first purchase",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            left: 16,
                            bottom: 30,
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: 4,
                              effect: const ExpandingDotsEffect(
                                activeDotColor: Colors.green,
                                dotColor: Colors.white,
                                dotHeight: 12,
                                dotWidth: 12,
                                spacing: 7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Categories
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFF000000),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 32),
              Container(
                height: 78,
                alignment: Alignment.center,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];

                    return InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(right: 13),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: category.color,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: Image.asset(category.icon, scale: 0.9),
                            ),
                            Text(
                              category.name,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF868889),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    mainAxisExtent: 234,
                    childAspectRatio: 0.1,
                  ),
                  itemCount: filterProducts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              product: filterProducts[index],
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
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
                                    onTap: () {
                                      addToCart(filterProducts[index]);
                                    },
                                    child: filterProducts[index].showQuantity
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.remove,
                                                  color: Color(0XFF6CC51D),
                                                ),
                                                onPressed: () {
                                                  decreaseQuantity(
                                                      filterProducts[index]);
                                                },
                                              ),
                                              Text(
                                                filterProducts[index]
                                                    .quantity
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0XFF6CC51D),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: Color(0XFF6CC51D),
                                                ),
                                                onPressed: () {
                                                  increaseQuantity(
                                                      filterProducts[index]);
                                                },
                                              )
                                            ],
                                          )
                                        : Row(
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
                                  left: 0,
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
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
