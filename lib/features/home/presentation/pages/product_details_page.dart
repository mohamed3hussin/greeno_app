import 'package:flutter/material.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';
import 'package:greeno_app/features/home/presentation/widgets/product_details_view.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
    required this.product
  });
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return ProductDetailsView(product: product);
  }
}
