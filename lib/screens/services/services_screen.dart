// lib/screens/services/services_screen.dart
import 'package:flutter/material.dart';
import '../../core/widgets/custom_app_bar.dart';
import 'models/service.dart';
import 'data/sample_services.dart';
import 'widgets/service_card.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  void _showServiceDetails(BuildContext context, Service service) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: 600,
            maxHeight: isSmallScreen ?
            MediaQuery.of(context).size.height * 0.8 :
            MediaQuery.of(context).size.height * 0.9,
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset(
                      service.icon,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.build_outlined,
                        size: 32,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        service.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        service.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),

                      Text(
                        'Features',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      ...service.features.map((feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                feature,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      )),

                      if (service.technologies != null) ...[
                        const SizedBox(height: 24),
                        Text(
                          'Technologies',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: service.technologies!.map((tech) => Chip(
                            label: Text(tech),
                            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          )).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Contact Button
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/contact');
                    },
                    child: const Text('Get in Touch'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth > 1200 ? (screenWidth - 1200) / 2 : 24.0;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Services'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: isSmallScreen ? 32 : 48,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  Text(
                    'What I Offer',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Comprehensive solutions for your digital needs',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Services Grid
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: 32,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = isSmallScreen ? 1 :
                  constraints.maxWidth > 900 ? 3 : 2;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: isSmallScreen ? 1.2 : 1.1,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                    ),
                    itemCount: sampleServices.length,
                    itemBuilder: (context, index) {
                      return ServiceCard(
                        service: sampleServices[index],
                        onTap: () => _showServiceDetails(context, sampleServices[index]),
                      );
                    },
                  );
                },
              ),
            ),

            // Call to Action Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: isSmallScreen ? 32 : 48,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  Text(
                    'Ready to Start Your Project?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Let\'s discuss how I can help bring your ideas to life',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/contact'),
                    child: const Text('Get in Touch'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}