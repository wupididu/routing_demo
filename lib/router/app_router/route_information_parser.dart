import 'package:flutter/material.dart';
import 'package:routing_demo/router/app_router/app_route.dart';

/// Route information parser for the application
/// Converts route information to/from AppRoute objects
class AppRouteInformationParser extends RouteInformationParser<AppRoute> {
  AppRouteInformationParser();

  AppRoute get initialState => parse(
    RouteInformation(
      uri: Uri.parse(
        WidgetsBinding.instance.platformDispatcher.defaultRouteName,
      ),
    ),
  );

  AppRoute parse(RouteInformation routeInformation) {
    final uri = routeInformation.uri;

    final segments = [...uri.pathSegments];

    // Handle root path
    if (segments.isEmpty) {
      return const HomeRoute();
    }

    var segment = segments.removeAt(0);

    // Handle login and register routes
    if (segment == 'login') {
      return const LoginRoute();
    }

    if (segment == 'register') {
      return const RegisterRoute();
    }

    return const HomeRoute();
  }

  @override
  Future<AppRoute> parseRouteInformation(
    RouteInformation routeInformation,
  ) async => parse(routeInformation);

  @override
  RouteInformation? restoreRouteInformation(AppRoute configuration) {
    return switch (configuration) {
      LoginRoute() => RouteInformation(uri: Uri(path: '/login')),
      RegisterRoute() => RouteInformation(uri: Uri(path: '/register')),
      HomeRoute() => RouteInformation(uri: Uri(path: '/home')),
    };
  }
}