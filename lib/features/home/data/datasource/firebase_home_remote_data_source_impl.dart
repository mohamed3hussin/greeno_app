import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greeno_app/core/errors/exceptions.dart';
import 'package:greeno_app/features/home/data/datasource/home_remote_data_source.dart';
import 'package:greeno_app/features/home/data/models/banner_model.dart';
import 'package:greeno_app/features/home/data/models/category_model.dart';
import 'package:greeno_app/features/home/data/models/product_model.dart';

class FirebaseHomeRemoteDataSourceImpl  implements HomeRemoteDataSource{

  final FirebaseFirestore firestore;

  FirebaseHomeRemoteDataSourceImpl({required this.firestore});



  @override
  Future<List<CategoryModel>> getCategories() async {
    try{
      final snapshot = await firestore.collection('categories').get();
      final List<CategoryModel> categories = snapshot.docs.map(
              (doc){
            return CategoryModel.fromJson(doc.data() , doc.id);
          }).toList();
      return categories;
    }on FirebaseException catch(e){
      throw ServerException(message: e.message ??'Something went wrong in category');
    }catch(e){
      throw const ServerException(message: 'Something went wrong in category');
    }

  }

  @override
  Future<List<ProductModel>> getProducts() async{
    try{
      final snapshot = await firestore.collection('products').get();
      final List<ProductModel> products = snapshot.docs.map(
              (doc){
                return ProductModel.fromJson(doc.data(), doc.id);
              }).toList();
      return products;
    }on FirebaseException catch(e){
      throw ServerException(message: e.message ?? 'Failed to load products');
    }catch(e){
      throw const ServerException(message: 'Failed to load products');
    }
  }

  @override
  Future<List<BannerModel>> getBanners() async{
    try{
      final snapshot = await firestore.collection('banners').get();
      final List<BannerModel> banners = snapshot.docs.map(
              (doc){
                return BannerModel.fromJson(doc.data(), doc.id);
              }).toList();
      return banners;
    }on FirebaseException catch(e){
      throw ServerException(message: e.message ?? 'Failed to load banners');
    }catch(e){
      throw const ServerException(message: 'Failed to load banners');
    }
  }

}