import 'package:store/app/commons/utils/enums/filter_type_enum.dart';
import 'package:store/app/features/product/data/dtos/product_dto.dart';

abstract class IProductDatasource {
  Future<void> createProduct({required ProductDto productDto, required String userId});
  Future<void> deleteProduct({required String productId, required String userId});
  Future<void> updateProduct({required ProductDto productDto, required String productId, required String userId});
  Future<List<ProductDto>> getProduct({FilterTypeEnum? orderBy, required String userId});
}
