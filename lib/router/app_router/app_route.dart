import 'package:flutter/material.dart';
import 'package:routing_demo/pages/home_page.dart';
import 'package:routing_demo/router/home_router/home_route.dart';
import '../../pages/login_page.dart';
import '../../pages/register_page.dart';

/// Sealed class representing all possible routes in the application
sealed class AppRoute {
  const AppRoute();

  /// Create a page for this route
  List<Page> createPages(BuildContext context);

  AppRoute back();

  HomeTabsState get homeState => switch (this) {
    HomeRoute(:final homeTabsState) => homeTabsState,
    _ => HomeTabsState(selectedTab: HomeTab.shop),
  };
}

/// Login route
class LoginRoute extends AppRoute {
  const LoginRoute();

  @override
  List<Page> createPages(BuildContext context) {
    return [
      const MaterialPage(
        key: ValueKey('login'),
        name: '/login',
        child: LoginPage(),
      ),
    ];
  }

  @override
  AppRoute back() => this;
}

/// Register route
class RegisterRoute extends AppRoute {
  const RegisterRoute();

  @override
  List<Page> createPages(BuildContext context) {
    return [
      const MaterialPage(
        key: ValueKey('login'),
        name: '/login',
        child: LoginPage(),
      ),
      const MaterialPage(
        key: ValueKey('register'),
        name: '/register',
        child: RegisterPage(),
      ),
    ];
  }

  @override
  AppRoute back() => const LoginRoute();
}

/// Home route - parent for all tabs
class HomeRoute extends AppRoute {
  final HomeTabsState homeTabsState;
  const HomeRoute(this.homeTabsState);

  @override
  List<Page> createPages(BuildContext context) {
    return [
      const MaterialPage(
        key: ValueKey('home'),
        name: '/home',
        child: HomePage(),
      ),
    ];
  }

  @override
  AppRoute back() => this;
}
