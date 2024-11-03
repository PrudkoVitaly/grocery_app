import 'package:flutter/material.dart';

import '../../domain/entities/category_entity.dart';
import '../models/category_model.dart';

class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCategories() async {
    return [
      CategoryModel(name: "Vegetables", icon: 'assets/vegetables_icon.png', color: Color(0XFFE6F2EA)),
      CategoryModel(name: "Fruits", icon: 'assets/fruits_icon.png', color: Color(0XFFFFE9E5)),
      CategoryModel(name: "Beverages", icon: 'assets/beverages_icon.png', color: Color(0XFFFFF6E3)),
      CategoryModel(name: "Grocery", icon: 'assets/grocery_icon.png', color: Color(0XFFF3EFFA)),
      CategoryModel(name: "Edible oil", icon: 'assets/edibleOil_icon.png', color: Color(0XFFDCF4F5)),
      CategoryModel(name: "Household", icon: 'assets/household_icon.png', color: Color(0XFFFFE8F2))
    ];
  }
}
