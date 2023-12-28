import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/app/commons/services/service_locator/service_locator.dart';
import 'package:store/app/commons/widgets/custom_snack_bar.dart';
import 'package:store/app/features/auth/domain/usecases/get_user_data.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/domain/usecases/create_product.dart';
import 'package:store/app/features/product/domain/usecases/update_product.dart';
import 'package:store/app/features/product/presenter/cubit/create_product/create_cubit_state.dart';
import 'package:store/app/commons/utils/utils.dart';

class CreateProductCubit extends Cubit<CreateProductCubitState> {
  final BuildContext context;
  CreateProductCubit(this.context) : super(CreateProductInitialState());

  final createProduct = getIt.get<CreateProduct>();
  final updateProduct = getIt.get<UpdateProduct>();
  final currentUser = getIt.get<GetUserData>();

  Future<void> create({
    required String name,
    required int code,
    String? price,
    String? imagePath,
    String? quantity,
  }) async {
    emit(CreateProductLoadingState());

    final formatedPrice = (price != null && price.isNotEmpty) ? currencyToDouble(price) : null;
    final formatedQuantity = (quantity != null && quantity.isNotEmpty) ? int.parse(quantity) : null;

    final product = ProductEntity(name: name, quantity: formatedQuantity, code: code, price: formatedPrice, createdAt: DateTime.now(), imagePath: imagePath);
    final user = await currentUser.getUser();
    user.fold((success) async {
      final result = await createProduct.create(product: product, userIdentifier: success.id);
      result.fold((success) {
        emit(CreateProductSuccessState());
        CustomSnackBar.show(context, message: 'Produto adicionado com sucesso!', success: true);

        context.pop();
        context.pushReplacement('/home_page');
      }, (failure) {
        emit(CreateProductErrorState());
        CustomSnackBar.show(context, message: 'Falha ao criar produto');
      });
    }, (failure) {
      emit(CreateProductErrorState());
      CustomSnackBar.show(context, message: 'Falha ao buscar usuário');
    });
  }

  Future<void> update({
    required String id,
    required String name,
    required int code,
    String? price,
    String? imagePath,
    String? quantity,
  }) async {
    emit(CreateProductLoadingState());

    final formatedPrice = (price != null && price.isNotEmpty) ? currencyToDouble(price) : null;
    final formatedQuantity = (quantity != null && quantity.isNotEmpty) ? int.parse(quantity) : null;

    final user = await currentUser.getUser();
    user.fold((success) async {
      final product = ProductEntity(id: id, name: name, quantity: formatedQuantity, code: code, price: formatedPrice, imagePath: imagePath);

      final result = await updateProduct.update(product: product, id: id, userId: success.id);
      result.fold((success) {
        emit(CreateProductSuccessState());
        CustomSnackBar.show(context, message: 'Produto alterado com sucesso!', success: true);
        context.pop();
        context.pushReplacement('/home_page');
      }, (failure) {
        emit(CreateProductErrorState());
        CustomSnackBar.show(context, message: 'Falha ao alterar produto');
      });
    }, (failure) {
      CustomSnackBar.show(context, message: 'Falha ao alterar produto');
    });
  }

  Future<XFile?> selectImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final result = await picker.pickImage(source: ImageSource.gallery);
      inspect(result);

      return result;
    } catch (_) {
      // ignore: use_build_context_synchronously
      CustomSnackBar.show(context, message: 'Erro ao carregar imagem');
      return null;
    }
  }
}
