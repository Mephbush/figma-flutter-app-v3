import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/about_screen.dart';
import '../screens/services_screen.dart';
import '../screens/portfolio_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/contact_screen_v3.dart';
import '../screens/features_screen.dart';

/// 🧭 نظام التنقل في التطبيق
class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String about = '/about';
  static const String services = '/services';
  static const String portfolio = '/portfolio';
  static const String contact = '/contact';
  static const String contactV3 = '/contact-v3';
  static const String features = '/features';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashScreen());
      
      case home:
        return _buildRoute(const HomeScreen());
      
      case about:
        return _buildRoute(const AboutScreen());
      
      case services:
        return _buildRoute(const ServicesScreen());
      
      case portfolio:
        return _buildRoute(const PortfolioScreen());
      
      case contact:
        return _buildRoute(const ContactScreen());
      
      case contactV3:
        return _buildRoute(const ContactScreenV3());
      
      case features:
        return _buildRoute(const FeaturesScreen());
      
      default:
        return _buildRoute(
          Scaffold(
            body: Center(
              child: Text('الصفحة غير موجودة: ${settings.name}'),
            ),
          ),
        );
    }
  }

  static PageRoute _buildRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}