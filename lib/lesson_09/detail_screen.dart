import 'package:flutter/material.dart';
import 'package:flutter_with_bay/lesson_09/lesson_09.dart';

class DetailScreen2 extends StatefulWidget {
  dynamic product;
  DetailScreen2({super.key, required this.product});

  @override
  State<DetailScreen2> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(widget.product.image),
            ),
            Text(widget.product.name),
            Text("${widget.product.price}"),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_border),
            ),
          ],
        ),
      ),
    );
  }
}
