import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store/app/commons/services/service_locator/service_locator.dart';
import 'package:store/app/commons/utils/Exceptions/custom_exception.dart';
import 'package:store/app/commons/widgets/custom_snack_bar.dart';
import 'package:store/app/features/auth/domain/usecases/create_user.dart';
import 'package:store/app/features/auth/domain/usecases/signin.dart';
import 'package:store/app/features/auth/presenter/cubit/auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final BuildContext context;
  AuthCubit(this.context) : super(AuthInitialState());

  final createUser = getIt.get<CreateUser>();
  final signinUser = getIt.get<Signin>();

  Future<void> createAccount({required String email, required String password}) async {
    emit(AuthLoadingState());
    final result = await createUser.create(email: email, password: password);
    result.fold((success) => emit(AuthSuccessState()), (failure) => emit(AuthErrorState()));
  }

  Future<void> signin({required String email, required String password}) async {
    emit(AuthLoadingState());
    final result = await signinUser.signin(email: email, password: password);
    result.fold((success) {
      emit(AuthSuccessState());
      context.go('/home_page');
    }, (failure) {
      emit(AuthErrorState());
      final message = _getErrorMessage(failure);
      CustomSnackBar.show(context, message: message);
    });
  }

  String _getErrorMessage(CustomException failure) {
    if (failure is InvalidUserCredentials) {
      return 'E-mail e/ou senha incorretos';
    } else if (failure is UnknowUserCredential) {
      return 'Erro desconhecido';
    } else {
      return 'Erro desconhecido';
    }
  }
}
