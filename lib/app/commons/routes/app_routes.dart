import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store/app/features/auth/presenter/cubit/auth_cubit.dart';
import 'package:store/app/features/auth/presenter/pages/create_account_page.dart';
import 'package:store/app/features/auth/presenter/pages/login_page.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/presenter/cubit/create_product/create_cubit.dart';
import 'package:store/app/features/product/presenter/cubit/product_list/products_cubit.dart';
import 'package:store/app/features/product/presenter/pages/create_product_page.dart';
import 'package:store/app/features/product/presenter/pages/home_page.dart';
import 'package:store/app/features/product/presenter/pages/product_details_page.dart';
import 'package:store/app/splash/presenter/pages/splash_page.dart';
import 'package:store/app/splash/presenter/cubit/splash_cubit.dart';

class AppRoutes {
  static final routes = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider(
          create: (context) => SplashCubit(context),
          child: const SplashPage(),
        ),
      ),
      GoRoute(
          name: 'home_page',
          path: '/home_page',
          builder: (context, state) => BlocProvider(
                create: (context) => ProductsCubit(context),
                child: const HomePage(),
              ),
          routes: [
            GoRoute(
                name: 'product_details',
                path: 'product_details',
                builder: (context, state) => MultiBlocProvider(
                      providers: [
                        BlocProvider<ProductsCubit>(create: (context) => ProductsCubit(context)),
                        BlocProvider<CreateProductCubit>(create: (context) => CreateProductCubit(context)),
                      ],
                      child: ProductDetailsPage(product: state.extra as ProductEntity),
                    )),
            GoRoute(
                name: 'create_product',
                path: 'create_product',
                builder: (context, state) => BlocProvider(
                      create: (context) => CreateProductCubit(context),
                      child: const CreateProductPage(),
                    )),
          ]),
      GoRoute(
        path: '/login_page',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(context),
          child: const LoginPage(),
        ),
        routes: [
          GoRoute(
            name: 'create_account',
            path: 'create_account',
            builder: (context, state) => BlocProvider(
              create: (context) => AuthCubit(context),
              child: const CreateAccountPage(),
            ),
          ),
        ],
      ),
    ],
  );
}
