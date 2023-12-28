import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';
import 'package:store/app/features/product/domain/repositories/i_product_repository.dart';

class DeleteProduct {
  final IProductRespository repository;
  const DeleteProduct({required this.repository});

  AsyncResult<Unit, CustomException> delete({required String productId, required String userId}) async {
    return await repository.delete(productId: productId, userId: userId);
  }
}
