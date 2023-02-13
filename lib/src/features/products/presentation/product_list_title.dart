import 'package:flutter/material.dart';
import 'package:ncdc_practice/src/features/products/model/product.dart';

class ProductListTitle extends StatelessWidget {
  const ProductListTitle({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(product.title ?? ''),
        ],
      ),
    );
  }
}
