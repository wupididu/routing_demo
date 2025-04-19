import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  AuthService();

  // Authentication state
  bool _isLoggedIn = false;

  // Getter for current state
  bool get isLoggedIn => _isLoggedIn;

  // Login method
  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  // Logout method
  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
