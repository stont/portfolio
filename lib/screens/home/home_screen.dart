// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
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
      3,
          (index) =>
          Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _fadeController,
              curve: Interval(
                  index * 0.2, (index * 0.2) + 0.6, curve: Curves.easeOut),
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
            Theme
                .of(context)
                .colorScheme
                .background,
            Theme
                .of(context)
                .colorScheme
                .background
                .withOpacity(0.8),
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
                child: Text(
                  'David Oluwabusayo',
                  style: Theme
                      .of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: widget.isMobile ? 32 : 48,
                  ),
                  textAlign: TextAlign.center,
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
                Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildNavigationItems(
                        spacing, iconSize, isHorizontal: true),
                  ),
                ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavigationItems(double spacing, double iconSize,
      {bool isHorizontal = false}) {
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
          icon: Icons.mail_outline,
          label: 'Contact',
          size: iconSize,
          onTap: () => Navigator.pushNamed(context, '/contact'),
        ),
      ),
    ];

    return items;
  }
}