import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/domain/repositories/i_product_repository.dart';

class UpdateProduct {
  final IProductRespository repository;
  const UpdateProduct({required this.repository});

  AsyncResult<Unit, CustomException> update({required ProductEntity product, required String id, required String userId}) async {
    return await repository.update(product: product, id: id, userId: userId);
  }
}
