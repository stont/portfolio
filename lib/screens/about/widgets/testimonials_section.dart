// lib/screens/about/widgets/testimonials_section.dart
import 'dart:async';

import 'package:flutter/material.dart';

class Testimonial {
  final String name;
  final String role;
  final String content;
  final String imageUrl;

  const Testimonial({
    required this.name,
    required this.role,
    required this.content,
    required this.imageUrl,
  });
}

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  final List<Testimonial> _testimonials = const [
    Testimonial(
      name: "John Doe",
      role: "Project Manager at Company X",
      content: "David is an exceptional Flutter developer who consistently delivers high-quality work. His attention to detail and problem-solving skills are outstanding.",
      imageUrl: "assets/images/testimonials/john.jpg",
    ),
    Testimonial(
      name: "Jane Smith",
      role: "Lead Developer at Tech Co",
      content: "Working with this developer has been a fantastic experience. Their Flutter expertise and communication skills made our project a success.",
      imageUrl: "assets/images/testimonials/john.jpg",
    ),
    Testimonial(
      name: "Mike Johnson",
      role: "CTO at Startup Y",
      content: "An excellent Flutter developer who brings both technical excellence and creative solutions to every project.",
      imageUrl: "assets/images/testimonials/john.jpg",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex < _testimonials.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Text(
            'Testimonials',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 300,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemCount: _testimonials.length,
              itemBuilder: (context, index) {
                return AnimatedScale(
                  scale: _currentIndex == index ? 1.0 : 0.9,
                  duration: const Duration(milliseconds: 300),
                  child: _buildTestimonialCard(_testimonials[index]),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _testimonials.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _pageController.animateToPage(
                  entry.key,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastOutSlowIn,
                ),
                child: Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary.withOpacity(
                      _currentIndex == entry.key ? 1 : 0.2,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Testimonial testimonial) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(testimonial.imageUrl),
            ),
            const SizedBox(height: 16),
            Text(
              testimonial.content,
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              testimonial.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              testimonial.role,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}