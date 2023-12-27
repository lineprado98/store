import 'package:store/app/features/product/data/dtos/product_dto.dart';

abstract class IProductDatasource {
  Future<void> createProduct({required ProductDto product, required String userIdentifier});
  Future<void> deleteProduct({required String id});
  Future<void> updateProduct({required ProductDto product, required String id});
  Future<List<ProductDto>> getProduct({dynamic filters, required String userIdentifier});
}
