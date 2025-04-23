import 'package:flutter/material.dart';

import 'home_route.dart';

abstract class HomeRouterStateManager with ChangeNotifier {
  HomeTabsState get state;

  void restore(HomeTabsState state);

  void selectTab(HomeTab tab) {
    state.selectedTab = tab;
    notifyListeners();
  }

  void setCurrentTab(int index) => selectTab(HomeTab.byIndex(index));

  void goToItem(int itemId) => _addToCurrentTab(ItemRoute(itemId));

  void goToItemFeedback(int itemId) => _addToCurrentTab(FeedbacksRoute(itemId));

  void goToOrders() => _addToCurrentTab(const OrdersRoute());

  void goToSettings() => _addToCurrentTab(const SettingsRoute());

  void goToLanguage() => _addToCurrentTab(const SettingsLanguageRoute());

  void goToAbout() => _addToCurrentTab(const SettingsAboutRoute());

  void _addToCurrentTab(HomeTabsRoute route) {
    state.currentTab.add(route);
    notifyListeners();
  }

  void popForTab(HomeTab tab, String name) {
    final tabRoutes = state.byTab(tab);

    if (tabRoutes.length == 1) {
      return;
    }

    if (tabRoutes.last.name == name) {
      tabRoutes.removeLast();
      notifyListeners();
    }
  }
}
