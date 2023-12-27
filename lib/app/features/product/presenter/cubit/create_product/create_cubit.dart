import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store/app/commons/services/service_locator/service_locator.dart';
import 'package:store/app/commons/widgets/custom_snack_bar.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/domain/usecases/create_product.dart';
import 'package:store/app/features/product/domain/usecases/update_product.dart';
import 'package:store/app/features/product/presenter/cubit/create_product/create_cubit_state.dart';

class CreateProductCubit extends Cubit<CreateProductCubitState> {
  final BuildContext context;
  CreateProductCubit(this.context) : super(CreateProductInitialState());

  final createProduct = getIt.get<CreateProduct>();
  final updateProduct = getIt.get<UpdateProduct>();

  Future<void> create({
    required String name,
    required int code,
    String? price,
    int? quantity,
  }) async {
    emit(CreateProductLoadingState());
    final product = ProductEntity(name: name, quantity: quantity, code: code, price: price);
    final result = await createProduct.create(product: product);
    result.fold((success) {
      emit(CreateProductSuccessState());
      CustomSnackBar.show(context, message: 'Produto adicionado com sucesso!', success: true);
      context.go('/home_page');
    }, (failure) {
      emit(CreateProductErrorState());
      CustomSnackBar.show(context, message: 'Falha ao criar produto');
    });
  }

  Future<void> update({
    required String id,
    required String name,
    required int code,
    String? price,
    int? quantity,
  }) async {
    emit(CreateProductLoadingState());
    final product = ProductEntity(id: id, name: name, quantity: quantity, code: code, price: price);

    final result = await updateProduct.update(product: product, id: id);
    result.fold((success) {
      emit(CreateProductSuccessState());
      CustomSnackBar.show(context, message: 'Produto alterado com sucesso!', success: true);
      context.go('/home_page');
    }, (failure) {
      emit(CreateProductErrorState());
      CustomSnackBar.show(context, message: 'Falha ao alterar produto');
    });
  }
}
