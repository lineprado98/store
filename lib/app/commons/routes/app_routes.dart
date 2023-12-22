import 'package:go_router/go_router.dart';
import 'package:store/app/commons/services/database/i_database_service.dart';
import 'package:store/app/commons/services/service_locator/service_locator.dart';
import 'package:store/app/splash/splash.dart';

class AppRoutes {
  static final routes = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Splash(db: getIt.get<IDatabaseService>()),
      )
    ],
  );
}
