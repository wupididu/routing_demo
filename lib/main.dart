import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:routing_demo/di.dart';
import 'package:routing_demo/router/app_router_refresher.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    context.read<AppRouterRefresher>();
    return MaterialApp.router(
      title: 'Навигация Демо',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: Provider.of<GoRouter>(context),
    );
  }
}
