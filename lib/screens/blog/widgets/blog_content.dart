// lib/screens/blog/widgets/blog_content.dart
import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../screens/blog_post_screen.dart';
import 'blog_post_card.dart';
import 'blog_search.dart';

class BlogContent extends StatefulWidget {
  const BlogContent({Key? key}) : super(key: key);

  @override
  State<BlogContent> createState() => _BlogContentState();
}

class _BlogContentState extends State<BlogContent> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  List<BlogPost> _filteredPosts = [];

  final List<BlogPost> _posts = [
    /*BlogPost(
      title: 'Getting Started with Flutter',
      summary: 'A comprehensive guide to starting your Flutter journey...',
      imageUrl: 'assets/images/blog/flutter-intro.jpg',
      category: 'Flutter',
      readTime: '5 min read',
      date: '2024-01-15',
      content: 'As 2025 begins, we at Paperless want to express our heartfelt gratitude for your trust and support throughout the years. Together, we’ve accomplished so much, and we’re excited about what lies ahead.\n\n\n'
          'This year, we’re committed to helping you achieve your goals with innovative tools and seamless solutions. Let’s make 2025 a year to remember! Wishing you success happiness and prosperity in the year ahead.',
    ),
    BlogPost(
      title: 'Tell your story in a Dynamic way',
      summary: 'A comprehensive guide to starting your Flutter journey...',
      imageUrl: 'assets/images/blog/story.jpg',
      category: 'Widget',
      readTime: '5 min read',
      date: '2024-01-15',
      content: 'Maria stayed ahead by dedicating one hour a week to exploring new tech trends. Her adaptability made her the go-to expert in her company.'
    ),
    BlogPost(
      title: 'Getting Started with Flutter',
      summary: 'A comprehensive guide to starting your Flutter journey...',
      imageUrl: 'assets/images/blog/flutter-intro.jpg',
      category: 'CI/CD',
      readTime: '5 min read',
      date: '2024-01-15',
      content: 'As 2025 begins, we at Paperless want to express our heartfelt gratitude for your trust and support throughout the years. Together, we’ve accomplished so much, and we’re excited about what lies ahead.\n\n\n'
          'This year, we’re committed to helping you achieve your goals with innovative tools and seamless solutions. Let’s make 2025 a year to remember! Wishing you success happiness and prosperity in the year ahead.',
    ),
    BlogPost(
      title: 'Getting Started with Flutter',
      summary: 'A comprehensive guide to starting your Flutter journey...',
      imageUrl: 'assets/images/blog/flutter-intro.jpg',
      category: 'Firebase',
      readTime: '5 min read',
      date: '2024-01-15',
      content: 'As 2025 begins, we at Paperless want to express our heartfelt gratitude for your trust and support throughout the years. Together, we’ve accomplished so much, and we’re excited about what lies ahead.\n\n\n'
          'This year, we’re committed to helping you achieve your goals with innovative tools and seamless solutions. Let’s make 2025 a year to remember! Wishing you success happiness and prosperity in the year ahead.',
    ),
    BlogPost(
      title: 'Getting Started with Flutter',
      summary: 'A comprehensive guide to starting your Flutter journey...',
      imageUrl: 'assets/images/blog/flutter-intro.jpg',
      category: 'Scarfold',
      readTime: '5 min read',
      date: '2024-01-15',
      content: 'As 2025 begins, we at Paperless want to express our heartfelt gratitude for your trust and support throughout the years. Together, we’ve accomplished so much, and we’re excited about what lies ahead.\n\n\n'
          'This year, we’re committed to helping you achieve your goals with innovative tools and seamless solutions. Let’s make 2025 a year to remember! Wishing you success happiness and prosperity in the year ahead.',
    ),
    BlogPost(
      title: 'Getting Started with Flutter',
      summary: 'A comprehensive guide to starting your Flutter journey...',
      imageUrl: 'assets/images/blog/flutter-intro.jpg',
      category: 'Flutter Library',
      readTime: '5 min read',
      date: '2024-01-15',
      content: 'As 2025 begins, we at Paperless want to express our heartfelt gratitude for your trust and support throughout the years. Together, we’ve accomplished so much, and we’re excited about what lies ahead.\n\n\n'
          'This year, we’re committed to helping you achieve your goals with innovative tools and seamless solutions. Let’s make 2025 a year to remember! Wishing you success happiness and prosperity in the year ahead.',
    ),*/
    // Add more blog posts
  ];

  @override
  void initState() {
    super.initState();
    _filteredPosts = _posts;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPosts(String query) {
    setState(() {
      _filteredPosts = _posts.where((post) {
        final matchesQuery = post.title.toLowerCase().contains(query.toLowerCase()) ||
            post.summary.toLowerCase().contains(query.toLowerCase());
        final matchesCategory = _selectedCategory == 'All' || post.category == _selectedCategory;
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  void _openBlogPost(BlogPost post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlogPostScreen(post: post),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final padding = screenWidth > 1200 ? (screenWidth - 1200) / 2 : 24.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Featured Post
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 400),
                  child: _buildFeaturedPost(),
                ),
                const SizedBox(height: 40),

                // Search and Filters
                BlogSearch(
                  controller: _searchController,
                  onSearch: _filterPosts,
                  selectedCategory: _selectedCategory,
                  categories: ['All', ...{..._posts.map((p) => p.category)}],
                  onCategoryChanged: (category) {
                    setState(() {
                      _selectedCategory = category ?? 'All';
                      _filterPosts(_searchController.text);
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Blog Posts Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = isSmallScreen ? 1 :
                    constraints.maxWidth > 900 ? 3 : 2;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: isSmallScreen ? 0.8 : 0.85,
                        mainAxisSpacing: 24,
                        crossAxisSpacing: 24,
                      ),
                      itemCount: _filteredPosts.length,
                      itemBuilder: (context, index) {
                        return BlogPostCard(post: _filteredPosts[index]);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeaturedPost() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(_posts.first.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8),
            ],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Featured Post',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _posts.first.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _openBlogPost(_posts.first),
              child: const Text('Read More'),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCategoryFilter() {
    // Extract unique categories from posts
    final categories = ['All', ...{..._posts.map((post) => post.category)}];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                  _filterPosts;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}