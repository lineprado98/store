class ProductEntity {
  final String? id;
  final String name;
  final String? price;
  final int? quantity;
  final int code;
  final List<String>? images;

  ProductEntity({
    required this.name,
    this.price,
    this.quantity,
    required this.code,
    this.images,
    this.id,
  });
}
