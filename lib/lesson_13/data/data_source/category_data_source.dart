import '../../domain/entities/category_entity.dart';
import '../models/category_model.dart';

class CategoryLocalDataSource{
  @override
  Future<List<CategoryModel>> getCategories() async {
    return [
      CategoryModel(name: "Category 1", icon: ''),
      CategoryModel(name: "Category 2", icon: ''),
      CategoryModel(name: "Category 3", icon: ''),
      CategoryModel(name: "Category 4", icon: ''),
      CategoryModel(name: "Category 5", icon: ''),
    ];
  }
}


