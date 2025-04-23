import 'package:flutter/material.dart';
import 'package:routing_demo/pages/cart/cart_page.dart';
import 'package:routing_demo/pages/profile/orders_page.dart';
import 'package:routing_demo/pages/profile/profile_page.dart';
import 'package:routing_demo/pages/profile/settings_page.dart';
import 'package:routing_demo/pages/shop/feedbacks_item_page.dart';
import 'package:routing_demo/pages/shop/item_page.dart';
import 'package:routing_demo/router/dialog_page.dart';

import '../../pages/shop/shop_page.dart';

enum HomeTab {
  shop,
  cart,
  profile;

  factory HomeTab.byIndex(int index) => values[index];
}

class HomeTabsState {
  HomeTab selectedTab;

  final List<HomeTabsRoute> shopTab = [const ShopListRoute()];
  final List<HomeTabsRoute> cartTab = [const CartListRoute()];
  final List<HomeTabsRoute> profileTab = [const ProfileMainRoute()];

  List<HomeTabsRoute> byTab(HomeTab tab) => switch (selectedTab) {
    HomeTab.shop => shopTab,
    HomeTab.cart => cartTab,
    HomeTab.profile => profileTab,
  };

  List<HomeTabsRoute> get currentTab => byTab(selectedTab);

  HomeTabsState({required this.selectedTab});
}

sealed class HomeTabsRoute {
  String get name;

  const HomeTabsRoute();

  /// Create a page for this route
  Page createPage(BuildContext context);
}

/// Shop tab route - parent for shop-related routes
sealed class ShopRoute extends HomeTabsRoute {
  const ShopRoute();
}

/// Shop list route (main shop page)
class ShopListRoute extends ShopRoute {
  @override
  final String name = '/shop';

  const ShopListRoute();

  @override
  Page createPage(BuildContext context) {
    return MaterialPage(
      key: const ValueKey('shop'),
      name: name,
      child: const ShopPage(),
    );
  }
}

/// Item details route
class ItemRoute extends ShopRoute {
  @override
  late final String name = '/item/$itemId';

  final int itemId;

  ItemRoute(this.itemId);

  @override
  Page createPage(BuildContext context) {
    return MaterialPage(
      key: ValueKey('item-$itemId'),
      name: name,
      child: ItemPage(itemId: itemId),
    );
  }
}

/// Feedbacks route for an item
class FeedbacksRoute extends ShopRoute {
  @override
  late final String name = '/item/$itemId/feedbacks';

  final int itemId;

  FeedbacksRoute(this.itemId);

  @override
  Page createPage(BuildContext context) {
    return MaterialPage(
      key: ValueKey('feedbacks-$itemId'),
      name: name,
      child: FeedbacksItemPage(itemId: itemId),
    );
  }
}

/// Cart tab route - parent for cart-related routes
sealed class CartRoute extends HomeTabsRoute {
  const CartRoute();
}

/// Cart list route (main cart page)
class CartListRoute extends CartRoute {
  @override
  final String name = '/cart';

  const CartListRoute();

  @override
  Page createPage(BuildContext context) {
    return MaterialPage(
      key: const ValueKey('cart'),
      name: name,
      child: const CartPage(),
    );
  }
}

/// Profile tab route - parent for profile-related routes
sealed class ProfileRoute extends HomeTabsRoute {
  const ProfileRoute();
}

/// Profile main route (main profile page)
class ProfileMainRoute extends ProfileRoute {
  @override
  final String name = '/profile';
  const ProfileMainRoute();

  @override
  Page createPage(BuildContext context) {
    return MaterialPage(
      key: const ValueKey('profile'),
      name: name,
      child: const ProfilePage(),
    );
  }
}

/// Orders route
class OrdersRoute extends ProfileRoute {
  @override
  final String name = '/profile/orders';
  const OrdersRoute();

  @override
  Page createPage(BuildContext context) {
    return MaterialPage(
      key: const ValueKey('orders'),
      name: name,
      child: const OrdersPage(),
    );
  }
}

/// Settings route
class SettingsRoute extends ProfileRoute {
  @override
  final String name = '/profile/settings';
  const SettingsRoute();

  @override
  Page createPage(BuildContext context) {
    return MaterialPage(
      key: const ValueKey('settings'),
      name: name,
      child: const SettingsPage(),
    );
  }
}

class SettingsLanguageRoute extends ProfileRoute {
  @override
  final String name = '/profile/settings/language';
  const SettingsLanguageRoute();

  @override
  Page createPage(BuildContext context) => DialogPage(
    key: const ValueKey('language'),
    name: name,
    child: const SettingsLanguageDialog(),
  );
}

class SettingsAboutRoute extends ProfileRoute {
  @override
  final String name = '/profile/settings/about';
  const SettingsAboutRoute();

  @override
  Page createPage(BuildContext context) => DialogPage(
    key: const ValueKey('about'),
    name: name,
    child: const SettingsAboutDialog(),
  );
}
