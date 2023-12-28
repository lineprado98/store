import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/domain/repositories/i_product_repository.dart';
import 'package:store/app/features/product/domain/usecases/update_product.dart';

class ProductRepositoryMock extends Mock implements IProductRespository {}

void main() {
  late IProductRespository productRespository;
  late UpdateProduct updateProduct;

  setUp(() {
    productRespository = ProductRepositoryMock();
    updateProduct = UpdateProduct(repository: productRespository);
  });

  test('Should return a success when create a product', () async {
    //arrange
    final product = ProductEntity(name: 'Teste', code: 123);
    const String productId = 'UjH86B8C0qP00qAKSUH2AOmfalv2';
    const String userId = 'UjH86B8C0qP00qAKSUH2AOmfalv2';
    when(() => productRespository.update(productEntity: product, productId: productId, userId: userId)).thenAnswer((_) async => Result.success(unit));

    //act
    final result = await updateProduct.update(productEntity: product, productId: productId, userId: userId);

    //assert
    expect(result, isA<Result<Unit, CustomException>>());
    expect(result.isSuccess(), true);
  });

  test('Should return a customException when update a product', () async {
    //arrange
    final product = ProductEntity(name: 'Teste', code: 123);
    const String productId = 'UjH86B8C0qP00qAKSUH2AOmfalv2';
    const String userId = 'UjH86B8C0qP00qAKSUH2AOmfalv2';
    when(() => productRespository.update(productEntity: product, productId: productId, userId: userId)).thenAnswer((_) async => Result.failure(DatabaseFailure()));

    //act
    final result = await updateProduct.update(productEntity: product, productId: productId, userId: userId);

    //assert
    expect(result, isA<Result<Unit, CustomException>>());
    expect(result.isError(), true);
  });
}
