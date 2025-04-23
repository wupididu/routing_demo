import '../../auth/auth_service.dart';
import 'app_route.dart';

class AppRouterGuard {
  final AuthService _authService;

  AppRouterGuard({required AuthService authService})
    : _authService = authService;

  AppRoute onState(AppRoute state) {
    if (!_authService.isLoggedIn &&
        state is! LoginRoute &&
        state is! RegisterRoute) {
      return const LoginRoute();
    }

    return state;
  }
}
