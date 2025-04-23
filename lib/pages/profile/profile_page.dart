import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/auth_service.dart';
import '../../router/home_router/home_router_delegate.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 20),
            const Text('Пользователь', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            const Text('user@example.com'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Используем HomeRouterDelegate для навигации
                HomeRouterDelegate.of(context).goToOrders();
              },
              child: const Text('Мои заказы'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Используем HomeRouterDelegate для навигации
                HomeRouterDelegate.of(context).goToSettings();
              },
              child: const Text('Настройки'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Просто вызываем logout(), навигация произойдет автоматически
                // благодаря реактивному слушателю в NavGuard
                Provider.of<AuthService>(context, listen: false).logout();
              },
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}
