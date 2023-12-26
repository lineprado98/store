import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/Exceptions/custom_exception.dart';
import 'package:store/app/features/product/data/datasource/i_product_datasource.dart';
import 'package:store/app/features/product/data/dtos/product_dto.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/domain/repositories/i_product_repository.dart';

class ProductRepository implements IProductRespository {
  final IProductDatasource datasource;
  const ProductRepository({required this.datasource});

  @override
  AsyncResult<Unit, CustomException> create({required ProductEntity value}) async {
    try {
      await datasource.createProduct(product: ProductDto.fromEntity(entity: value));
      return Success.unit();
    } on CustomException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Unit, CustomException> delete({required String id}) async {
    try {
      await datasource.deleteProduct(id: id);
      return Success.unit();
    } on CustomException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<List<ProductEntity>, CustomException> list({double? price, DateTime? date, orderBy}) async {
    try {
      final result = await datasource.getProduct();
      return Success(result);
    } on CustomException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Unit, CustomException> update({required ProductEntity product, required String id}) async {
    try {
      await datasource.updateProduct(product: ProductDto.fromEntity(entity: product), id: id);
      return Success.unit();
    } on CustomException catch (e) {
      return Failure(e);
    }
  }
}
