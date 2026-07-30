import 'package:greeno_app/features/home/domain/entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  BannerModel({
    required super.id,
    required super.image,
  });
  factory BannerModel.fromEntity(BannerEntity entity){
    return BannerModel(
        id: entity.id,
        image: entity.image,
    );
  }
  factory BannerModel.fromJson(Map<String,dynamic> json,String id){
    return BannerModel(
        id: id,
        image: json['image']as String,
    );
  }
  Map<String,dynamic> toJson(){
    return{
      'image':image,
    };
  }
}