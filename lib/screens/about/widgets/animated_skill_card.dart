// lib/screens/about/widgets/animated_skill_card.dart
import 'package:flutter/material.dart';

class AnimatedSkillCard extends StatefulWidget {
  final String skill;
  final double progress;
  final Duration delay;

  const AnimatedSkillCard({
    Key? key,
    required this.skill,
    required this.progress,
    required this.delay,
  }) : super(key: key);

  @override
  State<AnimatedSkillCard> createState() => _AnimatedSkillCardState();
}

class _AnimatedSkillCardState extends State<AnimatedSkillCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _progressAnimation =
        Tween<double>(begin: 0.0, end: widget.progress).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
        );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery
        .of(context)
        .size
        .width < 600;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme
              .of(context)
              .colorScheme
              .surface,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme
                  .of(context)
                  .colorScheme
                  .surface,
              Theme
                  .of(context)
                  .colorScheme
                  .surface
                  .withOpacity(0.8),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Theme
                  .of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Theme
                .of(context)
                .colorScheme
                .primary
                .withOpacity(0.1),
            width: 1,
          ),
        ),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedScale(
            scale: _isHovered ? 1.02 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.skill,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                        ),
                      ),
                      if (!isSmallScreen) const SizedBox(height: 4),
                      if (!isSmallScreen)
                        LinearProgressIndicator(
                          value: _progressAnimation.value,
                          backgroundColor: Theme
                              .of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme
                                .of(context)
                                .colorScheme
                                .primary,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                _buildAnimatedProgress(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedProgress(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size
        .width < 600 ? 45.0 : 60.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme
            .of(context)
            .colorScheme
            .primary
            .withOpacity(0.1),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: _progressAnimation.value,
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme
                  .of(context)
                  .colorScheme
                  .primary,
            ),
            strokeWidth: 4,
          ),
          Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                fontWeight: FontWeight.bold,
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
              ),
              child: Text(
                '${(_progressAnimation.value * 100).toInt()}%',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

