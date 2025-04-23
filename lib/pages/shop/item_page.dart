import 'package:flutter/material.dart';
import '../../router/home_router/home_router_delegate.dart';

class ItemPage extends StatelessWidget {
  final int itemId;

  const ItemPage({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Товар $itemId')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Информация о товаре $itemId',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text('Цена: ${itemId * 100} руб.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Используем HomeRouterDelegate для навигации
                HomeRouterDelegate.of(context).goToItemFeedback(itemId);
              },
              child: const Text('Отзывы'),
            ),
          ],
        ),
      ),
    );
  }
}
