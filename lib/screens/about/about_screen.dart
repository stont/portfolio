// lib/screens/about/about_screen.dart
import 'package:flutter/material.dart';
import 'package:portfolio/screens/about/widgets/skills_timeline.dart';
import 'package:portfolio/screens/about/widgets/testimonials_section.dart';
import '../../core/widgets/custom_app_bar.dart';
import 'widgets/typewriter_text.dart';
import 'widgets/animated_skill_card.dart';
import 'widgets/experience_timeline.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _imageAnimation;
  late Animation<Offset> _slideAnimation;
  bool _showImage = false;
  bool _showExperience = false;

  final String _aboutText = '''
Hello! I'm David Oluwabusayo, a passionate Flutter Developer with a keen interest in creating beautiful and functional mobile applications.

My journey in mobile development started with a deep fascination for creating user-friendly experiences that make a difference in people's lives.

I specialize in:
• Cross-platform development with Flutter
• Responsive UI design
• State management
• API integration
• Clean architecture implementation

When I'm not coding, you can find me exploring new technologies, contributing to open-source projects, or sharing knowledge with the developer community.
''';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _imageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTypingComplete() {
    setState(() => _showImage = true);
    _controller.forward().then((_) {
      setState(() => _showExperience = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery
        .of(context)
        .size
        .width < 600;

    return Scaffold(
      appBar: const CustomAppBar(title: 'About Me'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Existing about section
                if (isSmallScreen) ...[
                  _buildTypewriterText(),
                  if (_showImage) _buildProfileSection(),
                ] else
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildTypewriterText()),
                        if (_showImage)
                          Expanded(child: _buildProfileSection()),
                      ],
                    ),
                  ),

                // Skills Timeline Section
                if (_showExperience) ...[
                  const SizedBox(height: 60),
                  Text(
                    'Skills Journey',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),
                  const SizedBox(height: 24),
                  SkillTimeline(
                    skills: [
                      SkillEntry(
                        title: 'Flutter Development',
                        period: '2020 - Present',
                        description: 'Mastering cross-platform development with Flutter',
                        icon: Icons.flutter_dash,
                      ),
                      SkillEntry(
                        title: 'Mobile Development',
                        period: '2019 - 2020',
                        description: 'Started with native Android development',
                        icon: Icons.android,
                      ),
                      // Add more skills
                    ],
                  ),

                  // Experience Section
                  const SizedBox(height: 40),
                  _buildExperienceSection(),

                  // Skills Grid
                  const SizedBox(height: 40),
                  _buildSkillsGrid(),

                  // Testimonials Section
                  const SizedBox(height: 60),
                  const TestimonialsSection(),
                ],
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _showImage
          ? FloatingActionButton(
        onPressed: () => _downloadCV(context),
        child: const Icon(Icons.download),
        tooltip: 'Download CV',
      )
          : null,
    );
  }

  Widget _buildTypewriterText() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme
            .of(context)
            .colorScheme
            .surface,
        boxShadow: [
          BoxShadow(
            color: Theme
                .of(context)
                .shadowColor
                .withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TypewriterText(
        text: _aboutText,
        onTypingComplete: _onTypingComplete,
      ),
    );
  }

  Widget _buildProfileSection() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _imageAnimation,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme
                          .of(context)
                          .shadowColor
                          .withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/profile.jpg',
                    fit: BoxFit.cover,
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildQuickInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickInfo() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        _buildInfoCard(
          icon: Icons.location_on,
          title: 'Location',
          subtitle: 'Your Location',
        ),
        _buildInfoCard(
          icon: Icons.work,
          title: 'Experience',
          subtitle: '3+ Years',
        ),
        _buildInfoCard(
          icon: Icons.code,
          title: 'Projects',
          subtitle: '20+ Completed',
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme
            .of(context)
            .colorScheme
            .surface,
        boxShadow: [
          BoxShadow(
            color: Theme
                .of(context)
                .shadowColor
                .withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Theme
              .of(context)
              .colorScheme
              .primary),
          const SizedBox(height: 10),
          Text(title, style: Theme
              .of(context)
              .textTheme
              .titleMedium),
          Text(subtitle, style: Theme
              .of(context)
              .textTheme
              .bodyMedium),
        ],
      ),
    );
  }

  Widget _buildExperienceSection() {
    return ExperienceTimeline(
      experiences: [
        Experience(
          role: 'Senior Flutter Developer',
          company: 'Company A',
          duration: '2022 - Present',
          description: 'Led development of multiple successful apps...',
        ),
        Experience(
          role: 'Flutter Developer',
          company: 'Company B',
          duration: '2020 - 2022',
          description: 'Developed and maintained several Flutter applications...',
        ),
        // Add more experiences
      ],
    );
  }

  Widget _buildSkillsGrid() {
    final skills = [
      ('Flutter', 0.9),
      ('Dart', 0.85),
      ('Firebase', 0.8),
      ('REST APIs', 0.85),
      ('Git', 0.8),
      ('UI/UX Design', 0.75),
    ];

    // Get screen width
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    // Determine number of columns based on screen width
    final crossAxisCount = screenWidth < 600 ? 1 : // Mobile
    screenWidth < 900 ? 2 : // Tablet
    3; // Desktop

    // Adjust aspect ratio for different screen sizes
    final childAspectRatio = screenWidth < 600
        ? 3.0
        : // Mobile: more horizontal
    screenWidth < 900 ? 2.0 : // Tablet
    1.5; // Desktop

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: skills.length,
        itemBuilder: (context, index) {
          return AnimatedSkillCard(
            skill: skills[index].$1,
            progress: skills[index].$2,
            delay: Duration(milliseconds: 200 * index),
          );
        },
      ),
    );

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.5,
      ),
      itemCount: skills.length,
      itemBuilder: (context, index) {
        return AnimatedSkillCard(
          skill: skills[index].$1,
          progress: skills[index].$2,
          delay: Duration(milliseconds: 200 * index),
        );
      },
    );
  }


  void _downloadCV(BuildContext context) {
    // Implement CV download functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Downloading CV...')),
    );
  }
}