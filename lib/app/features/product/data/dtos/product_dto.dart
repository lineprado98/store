import 'package:store/app/commons/utils/collections/collections_keys.dart';
import 'package:store/app/commons/utils/collections/i_collection.dart';
import 'package:store/app/commons/utils/utils.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';

class ProductDto extends ProductEntity implements ICollection {
  final String? productId;
  final String productName;
  final String? image;
  final double? productPrice;
  final int? productQuantity;
  final int productCode;
  final DateTime? productCreatedAt;

  ProductDto({
    required this.productName,
    this.productPrice,
    this.productQuantity,
    required this.productCode,
    this.productId,
    this.productCreatedAt,
    this.image,
  }) : super(
          id: productId,
          name: productName,
          price: productPrice,
          quantity: productQuantity,
          code: productCode,
          createdAt: productCreatedAt,
          imagePath: image,
        );

  @override
  String get collectionName => CollectionsKeys.products;

  @override
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'productQuantity': productQuantity,
      'productCode': productCode,
      'productCreatedAt': productCreatedAt,
      'image': image,
    };
  }

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      productId: json['productId'],
      productName: json['productName'],
      productPrice: json['productPrice'],
      productQuantity: json['productQuantity'],
      productCode: json['productCode'],
      productCreatedAt: json['productCreatedAt'] != null ? fromTimestamp(json['productCreatedAt']) : null,
      image: json['image'],
    );
  }

  factory ProductDto.fromEntity({required ProductEntity entity}) {
    return ProductDto(
      productId: entity.id,
      productName: entity.name,
      productPrice: entity.price,
      productQuantity: entity.quantity,
      productCode: entity.code,
      productCreatedAt: entity.createdAt,
      image: entity.imagePath,
    );
  }
}
