import 'package:store/app/commons/services/database/i_database_service.dart';
import 'package:store/app/commons/utils/exceptions/exception_indentifier.dart';
import 'package:store/app/commons/utils/collections/collections_keys.dart';
import 'package:store/app/commons/utils/enums/filter_type_enum.dart';
import 'package:store/app/features/product/data/datasource/i_product_datasource.dart';
import 'package:store/app/features/product/data/dtos/product_dto.dart';

class ProductDatasource implements IProductDatasource {
  final IDatabaseService database;
  const ProductDatasource({required this.database});

  @override
  Future<void> createProduct({required ProductDto productDto, required String userId}) async {
    final result = await database.create(collection: productDto, userId: userId);
    if (result.success == false) {
      throw ExceptionIdentifier.handlerErrorDatabase(type: result.errorCode!);
    }
  }

  @override
  Future<void> deleteProduct({required String productId, required String userId}) async {
    final result = await database.delete(collectionName: CollectionsKeys.products, identifier: productId, userId: userId);
    if (result.success == false) {
      throw ExceptionIdentifier.handlerErrorDatabase(type: result.errorCode!);
    }
  }

  @override
  Future<List<ProductDto>> getProduct({FilterTypeEnum? orderBy, required String userId}) async {
    final result = await database.get(collectionName: CollectionsKeys.products, userId: userId, orderBy: orderBy);
    if (result.success == false) {
      throw ExceptionIdentifier.handlerErrorDatabase(type: result.errorCode!);
    }
    final list = result.data as List<Map<String, dynamic>>;

    final listProducts = list.map((item) => ProductDto.fromJson(item)).toList();

    return listProducts;
  }

  @override
  Future<void> updateProduct({required ProductDto productDto, required String productId, required String userId}) async {
    final result = await database.update(collection: productDto, identifier: productId, userId: userId);
    if (result.success == false) {
      throw ExceptionIdentifier.handlerErrorDatabase(type: result.errorCode!);
    }
  }
}
