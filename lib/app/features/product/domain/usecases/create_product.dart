import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/domain/repositories/i_product_repository.dart';

class CreateProduct {
  final IProductRespository repository;
  const CreateProduct({required this.repository});

  AsyncResult<Unit, CustomException> create({required ProductEntity productEntity, required String userId}) async {
    return repository.create(productEntity: productEntity, userId: userId);
  }
}
