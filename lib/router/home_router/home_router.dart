import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing_demo/router/home_router/home_route_information_parser.dart';
import 'package:routing_demo/router/home_router/home_router_state_manager.dart';

import 'home_router_delegate.dart';

/// Router for the home page with tabs
/// Manages the navigation for the tabs in the home page
class HomeRouter extends StatefulWidget {
  const HomeRouter({super.key});

  @override
  State<HomeRouter> createState() => _HomeRouterState();
}

class _HomeRouterState extends State<HomeRouter> {

  RouteInformation? get _rootRouteInformation {
    final router = Router.of(context);
    final parser = router.routeInformationParser;
    final delegate = router.routerDelegate;

    return parser?.restoreRouteInformation(delegate.currentConfiguration);
  }

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: HomeRouterDelegate(
        stateManager: context.read<HomeRouterStateManager>(),
      ),
      routeInformationParser: HomeRouteInformationParser(root: _rootRouteInformation),
      routeInformationProvider: Router.of(context).routeInformationProvider,
      backButtonDispatcher:
          Router.of(
              context,
            ).backButtonDispatcher!.createChildBackButtonDispatcher()
            ..takePriority(),
    );
  }
}
