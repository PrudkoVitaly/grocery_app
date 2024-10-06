import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Lessons_07 extends StatefulWidget {
  const Lessons_07({super.key});

  @override
  State<Lessons_07> createState() => _Lessons_07State();
}

class _Lessons_07State extends State<Lessons_07> {
  List<String> items = [
    'Apple',
    'Banana',
    'Orange',
    'Pineapple',
    'Strawberry',
    'Grapes',
    'Mango'
  ];

  List<int> priceList = [100, 230, 80, 420, 75];
  int minimum = 0;
  int maximum = 0;
  List<int> filteredPriceList = [];

  TextEditingController searchController = TextEditingController();

  List<String> filteredItems = [];

  void minimumPrice() {
    setState(() {
      filteredPriceList.sort((a, b) => a.compareTo(b));
      Navigator.pop(context);
    });
  }

  void maximumPrice() {
    setState(() {
      filteredPriceList.sort((a, b) => b.compareTo(a));
      Navigator.pop(context);
    });
  }

  void filterItems() {
    String searchText = searchController.text.toLowerCase();
    setState(() {
      filteredItems = items.where((element) {
        return element.toLowerCase().contains(searchText);
      }).toList();
    });
  }

  void showFilter() {
    showModalBottomSheet(
        context: (context),
        builder: (context) {
          return Container(
            height: 250,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      minimumPrice();
                    },
                    child: Text("Min price"),
                  ),
                  TextButton(
                    onPressed: () {
                      maximumPrice();
                    },
                    child: Text("Max price"),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter min price"),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter max price"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredItems = items;
    searchController.addListener(() {
      filterItems();
    });

    filteredPriceList = priceList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showFilter();
                      },
                      icon: const Icon(Icons.filter_list),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredPriceList.length,
                  itemBuilder: (context, index) {
                    return Text(
                      filteredPriceList[index].toString(),
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

List<int> numbers = [5, 6, 7, 1, 2, 3, 4];

void addData() {
  print(numbers);
  // numbers.insert(2, 10);
  // print(numbers);
  // // numbers.removeWhere((element) => element > 4);
  // // print(numbers);
  // numbers.retainWhere((element) => element > 4);
  // print(numbers);
  // var res = numbers.elementAt(2);
  // print(res);
  // var res = numbers.singleWhere((element) => element == 4);
  // print(res);
  // var res = numbers.contains(3);
  // print(res);
  // numbers.sort();
  // print(numbers);
  // numbers.shuffle();
  // print(numbers);
}
