import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/enums/filter_type_enum.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/domain/repositories/i_product_repository.dart';
import 'package:store/app/features/product/domain/usecases/list_product.dart';

class ProductRepositoryMock extends Mock implements IProductRespository {}

void main() {
  late IProductRespository productRespository;
  late ListProduct listProduct;
  setUp(() {
    productRespository = ProductRepositoryMock();
    listProduct = ListProduct(repository: productRespository);
  });
  test('Should return a success, with a list of products ', () async {
    //arrange
    const String userId = 'UjH86B8C0qP00qAKSUH2AOmfalv2';
    const FilterTypeEnum orderBy = FilterTypeEnum.date;
    final List<ProductEntity> productList = [];

    when(() => productRespository.list(orderBy: orderBy, userId: userId)).thenAnswer((_) async => Result.success(productList));

    //act
    final result = await listProduct.list(orderBy: orderBy, userId: userId);

    //assert
    expect(result, isA<Result<List<ProductEntity>, CustomException>>());
    expect(result.isSuccess(), true);
  });

  test('Should return a customException when  can not list  products', () async {
    //arrange
    const String userId = 'UjH86B8C0qP00qAKSUH2AOmfalv2';
    when(() => productRespository.list(userId: userId)).thenAnswer((_) async => Result.failure(DatabaseFailure()));

    //act
    final result = await listProduct.list(userId: userId);

    //assert
    expect(result, isA<Result<List<ProductEntity>, CustomException>>());
    expect(result.isError(), true);
  });
}
