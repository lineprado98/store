import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:store/app/commons/utils/exceptions/custom_exception.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/domain/repositories/i_product_repository.dart';
import 'package:store/app/features/product/domain/usecases/create_product.dart';

class ProductRepositoryMock extends Mock implements IProductRespository {}

void main() {
  late IProductRespository productRespository;
  late CreateProduct createProduct;
  setUp(() {
    productRespository = ProductRepositoryMock();
    createProduct = CreateProduct(repository: productRespository);
  });

  test('Should return a success when create a product', () async {
    //arrange
    final product = ProductEntity(name: 'Teste', code: 123);
    const userIdentifier = 'myUser';
    when(() => productRespository.create(productEntity: product, userId: userIdentifier)).thenAnswer((_) async => Result.success(unit));

    //act
    final result = await createProduct.create(productEntity: product, userId: userIdentifier);

    //assert
    expect(result, isA<Result<Unit, CustomException>>());
    expect(result.isSuccess(), true);
  });

  test('Should return a customException when create a product', () async {
    //arrange
    final product = ProductEntity(name: 'Teste', code: 123);
    const userIdentifier = 'myUser';
    when(() => productRespository.create(productEntity: product, userId: userIdentifier)).thenAnswer((_) async => Result.failure(DatabaseFailure()));

    //act
    final result = await createProduct.create(productEntity: product, userId: userIdentifier);

    //assert
    expect(result, isA<Result<Unit, CustomException>>());
    expect(result.isError(), true);
  });
}
