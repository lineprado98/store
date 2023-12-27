import 'package:store/app/features/product/domain/entities/product_entity.dart';

abstract class ProductsCubitState {}

class ProductsLoadingState implements ProductsCubitState {}

class ProductsErrorState implements ProductsCubitState {}

class ProductsSuccessState implements ProductsCubitState {
  final List<ProductEntity> products;

  ProductsSuccessState({required this.products});
}

class ProductsInitialState implements ProductsCubitState {}
