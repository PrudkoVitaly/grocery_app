
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../data_source/category_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource dataSource;

  CategoryRepositoryImpl(this.dataSource);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    return await CategoryLocalDataSource().getCategories();
  }
}