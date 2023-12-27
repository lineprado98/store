import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:store/app/splash/presenter/cubit/splash_cubit.dart';
import 'package:store/app/splash/presenter/cubit/splash_cubit_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  Future<void> redirect() async {
    BlocProvider.of<SplashCubit>(context).checkUserIsLogged();
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashCubitState>(
        listener: (context, state) {
          //TODO:Remover bloc listener e adicionar a navegação para o cubit
          state is LoggedUserState ? context.go('/home_page') : context.go('/login_page');
        },
        child: Scaffold(
          body: BlocBuilder<SplashCubit, SplashCubitState>(
              bloc: BlocProvider.of<SplashCubit>(context),
              builder: (context, state) {
                return const Center(
                  child: Text('Loading...'),
                );
              }),

          //   state is LoadingSplashState
          //       ? Scaffold(
          //           body: Center(

          //               // child: SvgPicture.asset(
          //               //   AppAssets.logo,
          //               //   width: 70,
          //               //   height: 70,
          //               // ),
          //               ))
          //       : Container();
          //}),
        ));
  }
}
