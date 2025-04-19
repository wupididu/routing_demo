import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing_demo/di.dart';
import 'auth/auth_service.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const DI(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return MaterialApp(
      title: 'Навигация Демо',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        // Проверка авторизации для всех маршрутов, кроме login и register
        if (!authService.isLoggedIn &&
            settings.name != '/login' &&
            settings.name != '/register') {
          return MaterialPageRoute(builder: (context) => const LoginPage());
        }

        return switch (settings.name) {
          '/login' => MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          '/register' => MaterialPageRoute(
            builder: (context) => const RegisterPage(),
          ),
          '/home' => MaterialPageRoute(builder: (context) => const HomePage()),
          '/' => MaterialPageRoute(builder: (context) => const HomePage()),
          _ => throw UnimplementedError(),
        };
      },
    );
  }
}
