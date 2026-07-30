import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String id;
  final String image;

  const BannerEntity({
    required this.id,
    required this.image,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    image,
  ];
}