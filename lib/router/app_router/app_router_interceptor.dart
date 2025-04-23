import '../../auth/auth_service.dart';
import 'app_route.dart';

class AppRouterInterceptor {
  final AuthService _authService;

  AppRouterInterceptor({required AuthService authService})
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
