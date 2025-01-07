// lib/screens/blog/widgets/blog_post_card.dart
import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../screens/blog_post_screen.dart';

class BlogPostCard extends StatefulWidget {
  final BlogPost post;

  const BlogPostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<BlogPostCard> createState() => _BlogPostCardState();
}

class _BlogPostCardState extends State<BlogPostCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogPostScreen(post: widget.post),
          ),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
          child: Card(
            elevation: _isHovered ? 8 : 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      widget.post.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Theme.of(context).colorScheme.surface,
                          child: Icon(
                            Icons.article,
                            size: 50,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Content Section
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category and Date Row
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                widget.post.category,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 10 : 12,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.post.date,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: isSmallScreen ? 10 : 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isSmallScreen ? 8 : 12),

                        // Title
                        Text(
                          widget.post.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: isSmallScreen ? 16 : 20,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: isSmallScreen ? 4 : 8),

                        // Summary
                        if (!isSmallScreen || MediaQuery.of(context).size.height > 700)
                          Expanded(
                            child: Text(
                              widget.post.summary,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: isSmallScreen ? 12 : 14,
                              ),
                              maxLines: isSmallScreen ? 2 : 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        // Read time
                        Padding(
                          padding: EdgeInsets.only(top: isSmallScreen ? 8 : 12),
                          child: Row(
                            children: [
                              Icon(Icons.access_time,
                                size: isSmallScreen ? 14 : 16,
                                color: Theme.of(context).textTheme.bodySmall?.color,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.post.readTime,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: isSmallScreen ? 10 : 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}