import 'package:flutter/material.dart';
import 'package:store/app/commons/routes/app_routes.dart';
import 'package:store/app/commons/theme/app_theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.theme(),
      routerConfig: AppRoutes.routes,
    );
  }
}
