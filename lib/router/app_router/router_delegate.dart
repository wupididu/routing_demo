import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:routing_demo/router/app_router/app_route.dart';
import 'package:routing_demo/router/app_router/app_router_state_manager.dart';
import 'package:routing_demo/router/navigator_observer.dart';

/// Router delegate for the application
/// Manages the navigation stack and handles navigation requests
class AppRouterDelegate extends RouterDelegate<AppRoute>
    with PopNavigatorRouterDelegateMixin<AppRoute> {
  /// Get the router delegate from the context
  static AppRouterDelegate of(BuildContext context) {
    final router = Router.of(context);
    assert(
      router.routerDelegate is AppRouterDelegate,
      'Router delegate is not AppRouterDelegate',
    );
    return router.routerDelegate as AppRouterDelegate;
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final AppRouterStateManager appRouterStateManager;

  AppRouterDelegate(this.appRouterStateManager);

  @override
  AppRoute get currentConfiguration => appRouterStateManager.state;

  @override
  Future<void> setNewRoutePath(AppRoute configuration) async {
    appRouterStateManager.restore(configuration);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: appRouterStateManager.state.createPages(context),
      onDidRemovePage: (page) {
        pop();
      },
      observers: [NavigatorObserverImpl('AppRouterDelegate')],
    );
  }

  @override
  void addListener(VoidCallback listener) {
    appRouterStateManager.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    appRouterStateManager.removeListener(listener);
  }

  void goToLogin() => appRouterStateManager.goToLogin();

  void goToRegister() => appRouterStateManager.goToRegister();

  void pop() => appRouterStateManager.back();
}
