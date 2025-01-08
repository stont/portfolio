// lib/screens/contact/contact_screen.dart
import 'package:flutter/material.dart';
import '../../core/widgets/custom_app_bar.dart';
import 'widgets/contact_form.dart';
import 'widgets/social_links.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Contact'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isSmallScreen)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildContactInfo(context)),
                        const SizedBox(width: 40),
                        const Expanded(child: ContactForm()),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildContactInfo(context),
                        const SizedBox(height: 40),
                        const ContactForm(),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get in Touch',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Let\'s work together! Feel free to reach out for collaborations, opportunities, or just to say hello.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),
        _buildContactMethod(
          context,
          icon: Icons.email_outlined,
          title: 'Email',
          content: 'david@paperlessenv.app',
        ),
        const SizedBox(height: 16),
        _buildContactMethod(
          context,
          icon: Icons.location_on_outlined,
          title: 'Location',
          content: '7.376736, 3.939786',
        ),
        const SizedBox(height: 40),
        const SocialLinks(),
      ],
    );
  }

  Widget _buildContactMethod(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String content,
      }) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}