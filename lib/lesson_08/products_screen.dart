import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Map<String, dynamic>> products = [
    {
      "name": "Apple",
      "image": "assets/Frame5.png",
      "price": 1.99,
      "like": false
    },
    {
      "name": "Iphone",
      "image": "assets/Frame4.png",
      "price": 3.00,
      "like": false
    },
    {
      "name": "Lenovo",
      "image": "assets/Frame3.png",
      "price": 200,
      "like": false
    },
    {
      "name": "LG",
      "image": "assets/Frame2.png",
      "price": 130,
      "like": false
    }
  ];

  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredProducts = products;
    searchController.addListener(searchProduct);
  }

  void searchProduct() {
    String value = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = products.where((element) {
        String productsName = element["name"].toLowerCase();
        return productsName.contains(value);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.filter))
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  filteredProducts[index]["like"] =
                                      !filteredProducts[index]
                                          ["like"];
                                });
                              },
                              icon: filteredProducts[index]["like"]
                                  ? Icon(Icons.favorite,
                                      color: Colors.red)
                                  : Icon(Icons.favorite_border),
                            ),
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                                filteredProducts[index]["image"]),
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                filteredProducts[index]["name"],
                              ),
                              Text(
                                filteredProducts[index]["price"]
                                    .toString(),
                              ),
                            ],
                          )
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
