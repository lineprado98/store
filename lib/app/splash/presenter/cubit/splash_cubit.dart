import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:store/app/commons/services/service_locator/service_locator.dart';
import 'package:store/app/commons/widgets/custom_snack_bar.dart';
import 'package:store/app/features/auth/domain/usecases/get_user_data.dart';
import 'package:store/app/splash/presenter/cubit/splash_cubit_state.dart';

class SplashCubit extends Cubit<SplashCubitState> {
  final BuildContext context;
  SplashCubit(this.context) : super(LoadingSplashState());

  final getUserData = getIt.get<GetUserData>();

  Future<void> checkUserIsLogged() async {
    final result = await getUserData.getUser();
    result.fold((success) async {
      FlutterNativeSplash.remove();
      await Future.delayed(const Duration(seconds: 3)).then((_) {
        success.email.isNotEmpty ? context.go('/home_page') : context.go('/login_page');
      });
    }, (failure) {
      CustomSnackBar.show(context, message: 'Erro ao validar usuário');
    });
  }
}
