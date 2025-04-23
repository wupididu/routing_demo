import 'package:flutter/material.dart';
import 'package:routing_demo/router/home_router/home_route.dart';
import 'package:routing_demo/router/home_router/home_router_state_manager.dart';
import 'package:routing_demo/router/navigator_observer.dart';

/// Router delegate for the home page with tabs
/// Manages the navigation for the tabs in the home page
class HomeRouterDelegate extends RouterDelegate<HomeTabsState>
    with PopNavigatorRouterDelegateMixin<HomeTabsState> {
  /// Static method to get the HomeRouterDelegate from the context
  static HomeRouterDelegate of(BuildContext context) {
    final router = Router.of(context);
    assert(
      router.routerDelegate is HomeRouterDelegate,
      'Router delegate is not HomeRouterDelegate',
    );
    return router.routerDelegate as HomeRouterDelegate;
  }

  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  GlobalKey<NavigatorState> get navigatorKey =>
      _navigatorKeys[_state.selectedTab.index];

  final HomeRouterStateManager _stateManager;

  HomeRouterDelegate({required HomeRouterStateManager stateManager})
    : _stateManager = stateManager;

  HomeTabsState get _state => _stateManager.state;

  @override
  HomeTabsState get currentConfiguration => _stateManager.state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildNestedNavigator(context, _state.selectedTab),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _state.selectedTab.index,
        onTap: _stateManager.setCurrentTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Магазин'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }

  /// Build a nested navigator for a tab
  Widget _buildNestedNavigator(BuildContext context, HomeTab selectedTab) =>
      Navigator(
        key: navigatorKey,
        pages:
            _state
                .byTab(selectedTab)
                .map((route) => route.createPage(context))
                .toList(),
        onDidRemovePage: (page) {
          _stateManager.popForTab(selectedTab, page.name!);
        },
        observers: [NavigatorObserverImpl('HomeRouterDelegate')],
      );

  @override
  Future<void> setNewRoutePath(HomeTabsState state) async =>
      _stateManager.restore(state);

  @override
  void addListener(VoidCallback listener) {
    _stateManager.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _stateManager.removeListener(listener);
  }

  void goToItem(int itemId) => _stateManager.goToItem(itemId);

  void goToItemFeedback(int itemId) => _stateManager.goToItemFeedback(itemId);

  void goToOrders() => _stateManager.goToOrders();

  void goToSettings() => _stateManager.goToSettings();

  void goToLanguage() => _stateManager.goToLanguage();

  void goToAbout() => _stateManager.goToAbout();
}
