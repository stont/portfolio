// lib/screens/projects/models/project.dart
class Project {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> categories;
  final List<String> technologies;
  final String githubUrl;
  final String? liveUrl;

  Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.categories,
    required this.technologies,
    required this.githubUrl,
    this.liveUrl,
  });
}