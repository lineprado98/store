import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/Exceptions/custom_exception.dart';
import 'package:store/app/commons/utils/enums/filter_type_enum.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';

abstract class IProductRespository {
  AsyncResult<Unit, CustomException> create({required ProductEntity value, required String userIdentifier});
  AsyncResult<Unit, CustomException> delete({required String id});
  AsyncResult<Unit, CustomException> update({required ProductEntity product, required String id});
  AsyncResult<List<ProductEntity>, CustomException> list({FilterTypeEnum? orderBy, required String userIdentifier});
}
