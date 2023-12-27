import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/Exceptions/custom_exception.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/domain/repositories/i_product_repository.dart';

class ListProduct {
  final IProductRespository repository;
  const ListProduct({required this.repository});

  AsyncResult<List<ProductEntity>, CustomException> list({double? price, DateTime? date, orderBy, required String userIdentifier}) async {
    return await repository.list(userIdentifier: userIdentifier);
  }
}
