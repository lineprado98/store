import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/Exceptions/custom_exception.dart';
import 'package:store/app/commons/utils/enums/filter_type_enum.dart';
import 'package:store/app/features/product/data/datasource/i_product_datasource.dart';
import 'package:store/app/features/product/data/dtos/product_dto.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/domain/repositories/i_product_repository.dart';
import 'package:store/app/features/product/presenter/widgets/chip_button_widget.dart';

class ProductRepository implements IProductRespository {
  final IProductDatasource datasource;
  const ProductRepository({required this.datasource});

  @override
  AsyncResult<Unit, CustomException> create({required ProductEntity value, required String userIdentifier}) async {
    try {
      await datasource.createProduct(product: ProductDto.fromEntity(entity: value), userIdentifier: userIdentifier);
      return Success.unit();
    } on CustomException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Unit, CustomException> delete({required String id, required String userId}) async {
    try {
      await datasource.deleteProduct(id: id, userId: userId);
      return Success.unit();
    } on CustomException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<List<ProductEntity>, CustomException> list({FilterTypeEnum? orderBy, required String userIdentifier}) async {
    try {
      final result = await datasource.getProduct(orderBy: orderBy, userIdentifier: userIdentifier);
      return Success(result);
    } on CustomException catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<Unit, CustomException> update({required ProductEntity product, required String id, required String userId}) async {
    try {
      await datasource.updateProduct(product: ProductDto.fromEntity(entity: product), id: id, userId: userId);
      return Success.unit();
    } on CustomException catch (e) {
      return Failure(e);
    }
  }
}
