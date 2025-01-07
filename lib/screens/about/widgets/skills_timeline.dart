// lib/screens/about/widgets/skills_timeline.dart
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SkillTimeline extends StatelessWidget {
  final List<SkillEntry> skills;

  const SkillTimeline({
    Key? key,
    required this.skills,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: skills.length,
      itemBuilder: (context, index) {
        final skill = skills[index];
        return Stack(
          children: [
            // Timeline line
            Positioned(
              left: 20,
              top: index == 0 ? 30 : 0,
              bottom: index == skills.length - 1 ? 30 : 0,
              child: Container(
                width: 2,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline dot
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        skill.icon,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          skill.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          skill.period,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          skill.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class SkillEntry {
  final String title;
  final String period;
  final String description;
  final IconData icon;

  SkillEntry({
    required this.title,
    required this.period,
    required this.description,
    required this.icon,
  });
}