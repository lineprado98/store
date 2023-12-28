import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';
import 'package:store/app/commons/utils/enums/filter_type_enum.dart';
import 'package:store/app/features/product/data/datasource/i_product_datasource.dart';
import 'package:store/app/features/product/data/dtos/product_dto.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/domain/repositories/i_product_repository.dart';

class ProductRepository implements IProductRespository {
  final IProductDatasource datasource;
  const ProductRepository({required this.datasource});

  @override
  AsyncResult<Unit, CustomException> create({required ProductEntity productEntity, required String userId}) async {
    try {
      await datasource.createProduct(productDto: ProductDto.fromEntity(entity: productEntity), userId: userId);
      return Success.unit();
    } on CustomException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Unit, CustomException> delete({required String productId, required String userId}) async {
    try {
      await datasource.deleteProduct(productId: productId, userId: userId);
      return Success.unit();
    } on CustomException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<List<ProductEntity>, CustomException> list({FilterTypeEnum? orderBy, required String userId}) async {
    try {
      final result = await datasource.getProduct(orderBy: orderBy, userId: userId);
      return Success(result);
    } on CustomException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Unit, CustomException> update({required ProductEntity productEntity, required String productId, required String userId}) async {
    try {
      await datasource.updateProduct(productDto: ProductDto.fromEntity(entity: productEntity), productId: productId, userId: userId);
      return Success.unit();
    } on CustomException catch (e) {
      return Failure(e);
    }
  }
}
