import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing_demo/auth/auth_service.dart';
import 'package:routing_demo/router/app_router/app_router_interceptor.dart';
import 'package:routing_demo/router/app_router/app_router_mutator.dart';
import 'package:routing_demo/router/app_router/app_router_state_manager.dart';
import 'package:routing_demo/router/app_router/route_information_parser.dart';
import 'package:routing_demo/router/home_router/home_route_information_parser.dart';
import 'package:routing_demo/router/home_router/home_router_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DI extends StatelessWidget {
  final Widget child;
  final SharedPreferences sharedPreferences;
  const DI({super.key, required this.child, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      Provider<AuthService>(
        create: (context) => AuthService(sharedPreferences),
      ),
      Provider<AppRouteInformationParser>(
        create: (context) => AppRouteInformationParser(),
      ),
    ],
    child: MultiProvider(
      providers: [
        Provider<AppRouterStateManager>(
          create:
              (context) => AppRouterStateManager(
                state: context.read<AppRouteInformationParser>().initialState,
                interceptor: AppRouterInterceptor(
                  authService: context.read<AuthService>(),
                ),
                mutator: AppRouterMutator(
                  authService: context.read<AuthService>(),
                ),
              )..init(),
        ),
      ],
      child: MultiProvider(
        providers: [
          Provider<HomeRouterStateManager>(
            create:
                (context) =>
                    context
                        .read<AppRouterStateManager>()
                        .homeRouterStateManager,
          ),
          Provider<HomeRouteInformationParser>(
            create:
                (context) =>
                    context
                        .read<AppRouteInformationParser>()
                        .homeRouteInformationParser,
          ),
        ],
        child: child,
      ),
    ),
  );
}
