import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

@freezed
class Product with _$Product {
  const factory Product({
    String? productId,
    String? author,
    String? title,
    String? description,
  }) = _Product;

  const Product._();
}
