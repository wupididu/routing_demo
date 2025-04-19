import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'shop/shop_page.dart';
import 'cart/cart_page.dart';
import 'profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, _) async {
        final didPop =
            await _navigatorKeys[_currentIndex].currentState!.maybePop();
        if (!didPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            NestedNavigator(
              navigatorKey: _navigatorKeys[0],
              child: const ShopPage(),
            ),
            NestedNavigator(
              navigatorKey: _navigatorKeys[1],
              child: const CartPage(),
            ),
            NestedNavigator(
              navigatorKey: _navigatorKeys[2],
              child: const ProfilePage(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Магазин'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Корзина',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
          ],
        ),
      ),
    );
  }
}

class NestedNavigator extends StatelessWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  const NestedNavigator({
    super.key,
    required this.child,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) => Navigator(
    key: navigatorKey,
    onGenerateRoute: (settings) {
      return MaterialPageRoute(builder: (context) => child, settings: settings);
    },
  );
}
