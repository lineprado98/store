import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/domain/repositories/i_product_repository.dart';

class CreateProduct {
  final IProductRespository repository;
  const CreateProduct({required this.repository});

  AsyncResult<Unit, CustomException> create({required ProductEntity product, required String userIdentifier}) async {
    return repository.create(value: product, userIdentifier: userIdentifier);
  }
}
