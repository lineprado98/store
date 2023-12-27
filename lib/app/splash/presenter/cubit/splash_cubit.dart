import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/app/commons/services/service_locator/service_locator.dart';
import 'package:store/app/features/auth/domain/usecases/get_user_data.dart';
import 'package:store/app/splash/presenter/cubit/splash_cubit_state.dart';

class SplashCubit extends Cubit<SplashCubitState> {
  SplashCubit() : super(LoadingSplashState());

  final getUserData = getIt.get<GetUserData>();

  Future<void> checkUserIsLogged() async {
    emit(LoadingSplashState());
    final result = await getUserData.getUser();
    result.fold((success) {
      success.email.isEmpty ? emit(LoggedOutUserState()) : emit(LoggedUserState());
    }, (failure) {});
  }
}
