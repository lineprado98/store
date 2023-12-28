class ProductEntity {
  final String? id;
  final String name;
  final double? price;
  final int? quantity;
  final int code;
  final String? imagePath;
  final DateTime? createdAt;

  ProductEntity({
    required this.name,
    this.price,
    this.quantity,
    required this.code,
    this.imagePath,
    this.id,
    this.createdAt,
  });
}
