import 'package:go_router/go_router.dart';
import 'package:routing_demo/auth/auth_service.dart';

class AppRouterRefresher {
  final AuthService _authService;
  final GoRouter _appRouter;

  AppRouterRefresher({
    required AuthService authService,
    required GoRouter appRouter,
  }) : _authService = authService,
       _appRouter = appRouter;

  void init() {
    _authService.addListener(() {
      print('refresh');
      _appRouter.refresh();
    });
  }
}
