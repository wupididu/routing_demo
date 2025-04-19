import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing_demo/auth/auth_service.dart';

class DI extends StatelessWidget {
  final Widget child;
  const DI({super.key, required this.child});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthService>.value(value: AuthService()),
    ],
    child: child,
  );
}
