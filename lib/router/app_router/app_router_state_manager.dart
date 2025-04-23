import 'package:flutter/material.dart';
import 'package:routing_demo/router/app_router/app_router_interceptor.dart';
import 'package:routing_demo/router/app_router/app_router_mutator.dart';
import 'package:routing_demo/router/home_router/home_route.dart';
import 'package:routing_demo/router/home_router/home_router_state_manager.dart';

import 'app_route.dart';

class AppRouterStateManager with ChangeNotifier {
  final AppRouterInterceptor _interceptor;
  final AppRouterMutator _mutator;
  late final HomeRouterStateManager _homeRouterStateManager =
      HomeRouterStateManagerImpl(appRouterStateManager: this);
  AppRoute _state;

  AppRouterStateManager({
    required AppRoute state,
    required AppRouterInterceptor interceptor,
    required AppRouterMutator mutator,
  }) : _state = state,
       _interceptor = interceptor,
       _mutator = mutator;

  AppRoute get state => _state;

  HomeRouterStateManager get homeRouterStateManager => _homeRouterStateManager;

  void init() {
    _mutator.addListener(_mutate);
  }

  @override
  void dispose() {
    _mutator.removeListener(_mutate);
    super.dispose();
  }

  void restore(AppRoute state) => _updateState(state);

  void goToLogin() => _updateState(const LoginRoute());

  void goToRegister() => _updateState(const RegisterRoute());

  void back() => _updateState(_state.back());

  void _updateState(AppRoute newState) {
    _state = _interceptor.onState(newState);
    notifyListeners();
  }

  void _mutate() => _updateState(_mutator.mutate(state));
}

class HomeRouterStateManagerImpl extends HomeRouterStateManager {
  final AppRouterStateManager appRouterStateManager;

  HomeRouterStateManagerImpl({required this.appRouterStateManager});

  @override
  void restore(HomeTabsState state) {
    appRouterStateManager._updateState(HomeRoute(state));
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
    appRouterStateManager.notifyListeners();
  }

  @override
  HomeTabsState get state => appRouterStateManager.state.homeState;
}
