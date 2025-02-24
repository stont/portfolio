// lib/core/routing/router.dart
import 'package:flutter/material.dart';
import '../../screens/blog/blog_screen.dart';
import '../../screens/services/services_screen.dart';
import 'custom_page_transition.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/about/about_screen.dart';
import '../../screens/projects/projects_screen.dart';
import '../../screens/contact/contact_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String about = '/about';
  static const String projects = '/projects';
  static const String services = '/services';
  static const String contact = '/contact';
  static const String blog = '/blog';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return CustomPageTransition(page: const HomeScreen());
      case about:
        return CustomPageTransition(page: const AboutScreen());
      case projects:
        return CustomPageTransition(page: const ProjectsScreen());
      case services:
        return CustomPageTransition(page: const ServicesScreen());
      case contact:
        return CustomPageTransition(page: const ContactScreen());
      case blog:
        return CustomPageTransition(page: const BlogScreen());
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