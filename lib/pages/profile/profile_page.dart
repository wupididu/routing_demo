import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/auth_service.dart';
import 'orders_page.dart';
import 'settings_page.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrdersPage()),
                );
              },
              child: const Text('Мои заказы'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
              child: const Text('Настройки'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Просто вызываем logout(), навигация произойдет автоматически
                // благодаря реактивному слушателю в MyApp
                Provider.of<AuthService>(context, listen: false).logout();
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushReplacementNamed('/login');
              },
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}
