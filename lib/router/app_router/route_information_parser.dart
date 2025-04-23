import 'package:flutter/material.dart';
import 'package:routing_demo/router/app_router/app_route.dart';
import 'package:routing_demo/router/home_router/home_route.dart';
import 'package:routing_demo/router/home_router/home_route_information_parser.dart';

/// Route information parser for the application
/// Converts route information to/from AppRoute objects
class AppRouteInformationParser extends RouteInformationParser<AppRoute> {
  final _homeRouteInformationParser = HomeRouteInformationParser();
  late final _homeRouteInformationParserWrapper =
      HomeRouteInformationParserWrapper(appRouteInformationParser: this);

  AppRouteInformationParser();

  AppRoute get initialState => parse(
    RouteInformation(
      uri: Uri.parse(
        WidgetsBinding.instance.platformDispatcher.defaultRouteName,
      ),
    ),
  );

  HomeRouteInformationParser get homeRouteInformationParser =>
      _homeRouteInformationParserWrapper;

  AppRoute parse(RouteInformation routeInformation) {
    final uri = routeInformation.uri;

    final segments = [...uri.pathSegments];

    // Handle root path
    if (segments.isEmpty) {
      return HomeRoute(
        _homeRouteInformationParser.parse(
          RouteInformation(uri: Uri(pathSegments: segments)),
        ),
      );
    }

    var segment = segments.removeAt(0);

    // Handle login and register routes
    if (segment == 'login') {
      return const LoginRoute();
    }

    if (segment == 'register') {
      return const RegisterRoute();
    }

    return HomeRoute(
      _homeRouteInformationParser.parse(
        RouteInformation(uri: Uri(pathSegments: segments)),
      ),
    );
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
      HomeRoute(:final homeTabsState) => RouteInformation(
        uri: Uri(
          pathSegments: [
            '/home',
            ..._homeRouteInformationParser
                    .restoreRouteInformation(homeTabsState)
                    ?.uri
                    .pathSegments ??
                [],
          ],
        ),
      ),
    };
  }
}

class HomeRouteInformationParserWrapper extends HomeRouteInformationParser {
  final AppRouteInformationParser _appRouteInformationParser;

  HomeRouteInformationParserWrapper({
    required AppRouteInformationParser appRouteInformationParser,
  }) : _appRouteInformationParser = appRouteInformationParser;

  @override
  Future<HomeTabsState> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final state = await _appRouteInformationParser.parseRouteInformation(
      routeInformation,
    );
    return state.homeState;
  }

  @override
  RouteInformation? restoreRouteInformation(HomeTabsState configuration) =>
      _appRouteInformationParser.restoreRouteInformation(
        HomeRoute(configuration),
      );
}
