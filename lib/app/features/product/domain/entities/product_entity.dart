class ProductEntity {
  final String? id;
  final String name;
  final double? price;
  final int quantity;
  final int code;
  final List<String>? images;

  ProductEntity({required this.name, this.price, required this.quantity, required this.code, this.images, this.id});
}
