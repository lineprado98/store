import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store/app/commons/services/service_locator/service_locator.dart';
import 'package:store/app/commons/widgets/custom_snack_bar.dart';
import 'package:store/app/features/auth/domain/usecases/signout.dart';
import 'package:store/app/features/product/domain/usecases/delete_product.dart';
import 'package:store/app/features/product/domain/usecases/list_product.dart';
import 'package:store/app/features/product/presenter/cubit/products_cubit_state.dart';

class ProductsCubit extends Cubit<ProductsCubitState> {
  final BuildContext context;
  ProductsCubit(this.context) : super(ProductsInitialState());

  final products = getIt.get<ListProduct>();
  final delete = getIt.get<DeleteProduct>();

  final auth = getIt.get<Signout>();

  Future<void> getProducts() async {
    emit(ProductsLoadingState());
    final result = await products.list();
    result.fold((success) => emit(ProductsSuccessState(products: success)), (error) => emit(ProductsErrorState()));
  }

  Future<void> signout() async {
    final result = await auth.signout();
    result.fold((success) => context.go('/login_page'), (error) => null);
  }

  Future<void> remove({required String productId}) async {
    final result = await delete.delete(id: productId);
    result.fold((success) {
      getProducts();
      CustomSnackBar.show(context, message: 'Produto removido com sucesso!', success: true);
    }, (error) {
      CustomSnackBar.show(context, message: 'Produto removido com sucesso!');
    });
  }
}
