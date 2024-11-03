import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomScrollView(
            slivers: [
              SearchBody(),
              CategoriesBody(),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
              ),),
              ProductBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("categories"),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            color: Colors.green,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Products"),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              width: 60,
              color: Colors.green,
              margin: const EdgeInsets.only(right: 15),
            );
          },
        ),
      ),
    );
  }
}

class ProductBody extends StatelessWidget {
  const ProductBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: 20,
        (context, index) {
          return Container(
            color: Colors.green,
          );
        },
      ),
    );
  }
}
