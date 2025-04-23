import 'package:flutter/material.dart';
import 'package:routing_demo/router/app_router/app_router_guard.dart';
import 'package:routing_demo/router/app_router/app_router_mutator.dart';

import 'app_route.dart';

class AppRouterStateManager with ChangeNotifier {
  final AppRouterGuard _guard;
  final AppRouterMutator _mutator;
  AppRoute _state;

  AppRouterStateManager({
    required AppRoute state,
    required AppRouterGuard guard,
    required AppRouterMutator mutator,
  }) : _state = state,
       _guard = guard,
       _mutator = mutator;

  AppRoute get state => _state;

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
    if (newState == _state) {
      return;
    }
    _state = _guard.onState(newState);
    notifyListeners();
  }

  void _mutate() {
    _updateState(_mutator.mutate(state));
  }
}