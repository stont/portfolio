// lib/screens/blog/models/blog_post.dart
class BlogPost {
  final String title;
  final String summary;
  final String imageUrl;
  final String category;
  final String readTime;
  final String date;
  final String content;

  BlogPost({
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.category,
    required this.readTime,
    required this.date,
    required this.content,
  });
}