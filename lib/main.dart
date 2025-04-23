import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:routing_demo/di.dart';
import 'package:routing_demo/router/app_router/route_information_parser.dart';
import 'package:routing_demo/router/app_router/router_delegate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'router/app_router/app_route.dart';
import 'router/app_router/app_router_state_manager.dart';

void main() async {
  Logger.root.onRecord.listen((event) {
    print('${event.loggerName} | ${event.level} | ${event.message}');
  });

  Provider.debugCheckInvalidValueType = null;

  if (kIsWeb) {
    usePathUrlStrategy();
  }
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(DI(sharedPreferences: sharedPreferences, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Навигация Демо',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: RouterConfig<AppRoute>(
        routerDelegate: AppRouterDelegate(
          context.read<AppRouterStateManager>(),
        ),
        routeInformationParser: AppRouteInformationParser(),
        routeInformationProvider: PlatformRouteInformationProvider(
          initialRouteInformation: RouteInformation(
            uri: Uri.parse(
              WidgetsBinding.instance.platformDispatcher.defaultRouteName,
            ),
          ),
        ),
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
