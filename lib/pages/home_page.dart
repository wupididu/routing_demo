import 'package:flutter/material.dart';
import '../router/home_router/home_router.dart';

/// Home page that uses the HomeRouter for nested navigation
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeRouter();
  }
}
