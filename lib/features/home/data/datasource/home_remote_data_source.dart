import 'package:greeno_app/features/home/data/models/banner_model.dart';
import 'package:greeno_app/features/home/data/models/category_model.dart';
import 'package:greeno_app/features/home/data/models/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getProducts();
  Future<List<BannerModel>> getBanners();
}