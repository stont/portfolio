// lib/core/routing/router.dart
import 'package:flutter/material.dart';
import 'custom_page_transition.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/about/about_screen.dart';
import '../../screens/projects/projects_screen.dart';
import '../../screens/contact/contact_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String about = '/about';
  static const String projects = '/projects';
  static const String contact = '/contact';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return CustomPageTransition(page: const HomeScreen());
      case about:
        return CustomPageTransition(page: const AboutScreen());
      case projects:
        return CustomPageTransition(page: const ProjectsScreen());
      case contact:
        return CustomPageTransition(page: const ContactScreen());
      default:
        return CustomPageTransition(
          page: Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}