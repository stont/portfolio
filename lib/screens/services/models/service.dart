// lib/screens/services/models/service.dart
class Service {
  final String title;
  final String description;
  final String icon;
  final List<String> features;
  final List<String>? technologies;

  Service({
    required this.title,
    required this.description,
    required this.icon,
    required this.features,
    this.technologies,
  });
}