// lib/screens/about/widgets/certifications_section.dart
import 'package:flutter/material.dart';
import '../models/certification.dart';
import 'certification_card.dart';

class CertificationsSection extends StatelessWidget {
  final List<Certification> certifications;

  const CertificationsSection({
    Key? key,
    required this.certifications,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Certifications',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        if (isMobile)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: certifications.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CertificationCard(
                certification: certifications[index],
                delay: Duration(milliseconds: 200 * index),
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth < 900 ? 2 : 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.2,
            ),
            itemCount: certifications.length,
            itemBuilder: (context, index) => CertificationCard(
              certification: certifications[index],
              delay: Duration(milliseconds: 200 * index),
            ),
          ),
      ],
    );
  }
}