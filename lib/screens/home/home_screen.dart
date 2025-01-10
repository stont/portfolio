// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../core/responsive/responsive_layout.dart';
import 'widgets/nav_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: _HomeContent(isMobile: true),
        tablet: _HomeContent(isMobile: false),
        desktop: _HomeContent(isMobile: false),
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  final bool isMobile;

  const _HomeContent({required this.isMobile});

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimations = List.generate(
      4,
          (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _fadeController,
          curve: Interval(
            index * 0.2,
            (index * 0.2) + 0.6,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = widget.isMobile ? 16.0 : 40.0;
    final iconSize = widget.isMobile ? 32.0 : 60.0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.background.withOpacity(0.8),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: widget.isMobile ? 20 : 40,
        vertical: widget.isMobile ? 16 : 24,
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              FadeTransition(
                opacity: _fadeAnimations[0],
                child: Column(
                  children: [
                    Text(
                      'David Oluwabusayo',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: widget.isMobile ? 32 : 48,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'is ',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: widget.isMobile ? 20 : 28,
                          ),
                        ),
                        AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'a Trainer',
                              textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: widget.isMobile ? 20 : 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              speed: const Duration(milliseconds: 60),
                            ),
                            TypewriterAnimatedText(
                              'a Community Manager',
                              textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: widget.isMobile ? 20 : 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              speed: const Duration(milliseconds: 60),
                            ),
                            TypewriterAnimatedText(
                              'a Flutter Developer',
                              textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: widget.isMobile ? 20 : 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              speed: const Duration(milliseconds: 60),
                            ),
                            TypewriterAnimatedText(
                              'a Web Developer',
                              textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: widget.isMobile ? 20 : 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              speed: const Duration(milliseconds: 60),
                            ),
                            TypewriterAnimatedText(
                              'a Mobile App Developer',
                              textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: widget.isMobile ? 20 : 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              speed: const Duration(milliseconds: 60),
                            ),
                            TypewriterAnimatedText(
                              'a Paperless Advocate',
                              textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: widget.isMobile ? 20 : 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              speed: const Duration(milliseconds: 60),
                            ),
                          ],
                          repeatForever: true,
                          pause: const Duration(milliseconds: 1000),
                          displayFullTextOnTap: true,
                          stopPauseOnTap: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: widget.isMobile ? 30 : 50),
              // Different layout for mobile and desktop
              if (widget.isMobile)
              // Mobile: Vertical layout
                Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _buildNavigationItems(spacing, iconSize),
                  ),
                )
              else
              // Desktop: Horizontal layout
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: _buildNavigationItems(spacing, iconSize, isHorizontal: true),
                    ),
                  ),
                ),
              const Spacer(),
              // Copyright Text
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  '© 2025 Paperless. All rights reserved.',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavigationItems(double spacing, double iconSize, {bool isHorizontal = false}) {
    final items = [
      FadeTransition(
        opacity: _fadeAnimations[1],
        child: NavIcon(
          icon: Icons.person_outline,
          label: 'About Me',
          size: iconSize,
          onTap: () => Navigator.pushNamed(context, '/about'),
        ),
      ),
      if (isHorizontal)
        SizedBox(width: spacing)
      else
        SizedBox(height: spacing),
      FadeTransition(
        opacity: _fadeAnimations[1],
        child: NavIcon(
          icon: Icons.work_outline,
          label: 'Projects',
          size: iconSize,
          onTap: () => Navigator.pushNamed(context, '/projects'),
        ),
      ),
      if (isHorizontal)
        SizedBox(width: spacing)
      else
        SizedBox(height: spacing),
      FadeTransition(
        opacity: _fadeAnimations[2],
        child: NavIcon(
          icon: Icons.handyman_outlined,
          label: 'Services',
          size: iconSize,
          onTap: () => Navigator.pushNamed(context, '/services'),
        ),
      ),
      if (isHorizontal)
        SizedBox(width: spacing)
      else
        SizedBox(height: spacing),
      FadeTransition(
        opacity: _fadeAnimations[2],
        child: NavIcon(
          icon: Icons.mail_outline,
          label: 'Contact',
          size: iconSize,
          onTap: () => Navigator.pushNamed(context, '/contact'),
        ),
      ),
      if (isHorizontal)
        SizedBox(width: spacing)
      else
        SizedBox(height: spacing),
      FadeTransition(
        opacity: _fadeAnimations[3],  // Changed from 2 to 3
        child: NavIcon(
          icon: Icons.article_outlined,
          label: 'Blog',
          size: iconSize,
          onTap: () => Navigator.pushNamed(context, '/blog'),
        ),
      ),
    ];

    // For desktop view, wrap items in a ConstrainedBox
    if (isHorizontal) {
      return [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: items,
          ),
        ),
      ];
    }

    return items;
  }
  }
