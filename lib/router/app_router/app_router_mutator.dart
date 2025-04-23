import 'package:flutter/material.dart';
import 'package:routing_demo/auth/auth_service.dart';
import 'package:routing_demo/router/app_router/app_route.dart';
import 'package:routing_demo/router/home_router/home_route.dart';

class AppRouterMutator {
  final AuthService _authService;

  AppRouterMutator({required AuthService authService})
    : _authService = authService;

  AppRoute mutate(AppRoute state) {
    if ((state is LoginRoute || state is RegisterRoute) &&
        _authService.isLoggedIn) {
      return HomeRoute(HomeTabsState(selectedTab: HomeTab.shop));
    }

    return state;
  }

  void addListener(VoidCallback listener) {
    _authService.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    _authService.removeListener(listener);
  }
}
