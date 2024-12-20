import 'package:flutter/material.dart';
import 'package:task/features/presentation/screens/product_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String products = '/products';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => ProductsScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}