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
  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: HomeRouterDelegate(
        stateManager: context.read<HomeRouterStateManager>(),
      ),
      routeInformationParser: Provider.of<HomeRouteInformationParser>(context),
      routeInformationProvider: Router.of(context).routeInformationProvider,
      backButtonDispatcher:
          Router.of(
              context,
            ).backButtonDispatcher!.createChildBackButtonDispatcher()
            ..takePriority(),
    );
  }
}
