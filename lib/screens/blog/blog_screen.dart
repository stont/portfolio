// lib/screens/blog/blog_screen.dart
import 'package:flutter/material.dart';
import '../../core/widgets/custom_app_bar.dart';
import 'widgets/blog_content.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Blog'),
      body: const BlogContent(),
    );
  }
}