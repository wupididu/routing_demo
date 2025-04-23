import 'package:flutter/material.dart';
import '../../router/home_router/home_router_delegate.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Магазин')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Товар ${index + 1}'),
            subtitle: Text('Описание товара ${index + 1}'),
            onTap: () {
              // Используем HomeRouterDelegate для навигации
              HomeRouterDelegate.of(context).goToItem(index + 1);
            },
          );
        },
      ),
    );
  }
}
