import 'package:greeno_app/features/home/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.image,
  });

  factory CategoryModel.fromJson(Map<String,dynamic> json, String id){
    return CategoryModel(
        id: id,
        name: json['name'] as String,
        image: json['image'] as String,
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'name':name,
      'image':image,
    };

  }

  factory CategoryModel.fromEntity(CategoryEntity entity){
    return CategoryModel(
        id: entity.id,
        name: entity.name,
        image: entity.image,
    );
  }
}