import 'package:flutter/material.dart';
import 'package:routing_demo/router/home_router/home_route.dart';

/// Route information parser for the application
/// Converts route information to/from AppRoute objects
class HomeRouteInformationParser extends RouteInformationParser<HomeTabsState> {
  HomeTabsState parse(RouteInformation routeInformation) {
    final uri = routeInformation.uri;

    // Parse the path segments
    final pathSegments = [...uri.pathSegments];

    if (pathSegments.isEmpty) {
      return HomeTabsState(selectedTab: HomeTab.shop);
    }

    var segment = pathSegments.removeAt(0);

    if (segment == 'shop') {
      final state = HomeTabsState(selectedTab: HomeTab.shop);

      if (pathSegments.isNotEmpty) {
        segment = pathSegments.removeAt(0);

        if (segment == 'item') {
          if (pathSegments.isNotEmpty) {
            segment = pathSegments.removeAt(0);

            final itemId = int.tryParse(segment);

            if (itemId != null) {
              state.shopTab.add(ItemRoute(itemId));

              if (pathSegments.isNotEmpty) {
                segment = pathSegments.removeAt(0);

                if (segment == 'feedback') {
                  state.shopTab.add(FeedbacksRoute(itemId));
                }
              }
            }
          }
        }
      }

      return state;
    }

    if (segment == 'cart') {
      final state = HomeTabsState(selectedTab: HomeTab.cart);

      if (pathSegments.isNotEmpty) {
        segment = pathSegments.removeAt(0);

        if (segment == 'item') {
          if (pathSegments.isNotEmpty) {
            segment = pathSegments.removeAt(0);

            final itemId = int.tryParse(segment);

            if (itemId != null) {
              state.shopTab.add(ItemRoute(itemId));

              if (pathSegments.isNotEmpty) {
                segment = pathSegments.removeAt(0);

                if (segment == 'feedback') {
                  state.shopTab.add(FeedbacksRoute(itemId));
                }
              }
            }
          }
        }
      }
      return state;
    }

    if (segment == 'profile') {
      final state = HomeTabsState(selectedTab: HomeTab.profile);

      if (pathSegments.isNotEmpty) {
        segment = pathSegments.removeAt(0);

        if (segment == 'settings') {
          state.profileTab.add(const SettingsRoute());

          if (pathSegments.isNotEmpty) {
            segment = pathSegments.removeAt(0);

            if (segment == 'language') {
              state.profileTab.add(const SettingsLanguageRoute());
            }

            if (segment == 'about') {
              state.profileTab.add(const SettingsAboutRoute());
            }
          }
        }

        if (segment == 'orders') {
          state.profileTab.add(const OrdersRoute());
        }
      }

      return state;
    }

    return HomeTabsState(selectedTab: HomeTab.shop);
  }

  @override
  Future<HomeTabsState> parseRouteInformation(
    RouteInformation routeInformation,
  ) async => parse(routeInformation);

  @override
  RouteInformation? restoreRouteInformation(HomeTabsState configuration) {
    final segments = <String>[
      switch (configuration.selectedTab) {
        HomeTab.shop => 'shop',
        HomeTab.cart => 'cart',
        HomeTab.profile => 'profile',
      },
      for (final route in configuration.currentTab)
        switch (route) {
          ShopListRoute() => '',
          ItemRoute(itemId: final itemId) => 'item/$itemId',
          FeedbacksRoute() => 'feedback',
          CartListRoute() => '',
          ProfileMainRoute() => '',
          OrdersRoute() => 'orders',
          SettingsRoute() => 'settings',
          SettingsLanguageRoute() => 'language',
          SettingsAboutRoute() => 'about',
        },
    ];

    segments.removeWhere((segment) => segment.isEmpty);

    return RouteInformation(uri: Uri(pathSegments: segments));
  }
}
