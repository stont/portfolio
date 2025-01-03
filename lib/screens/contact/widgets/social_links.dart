// lib/screens/contact/widgets/social_links.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({Key? key}) : super(key: key);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect with Me',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _SocialButton(
              icon: Icons.link,
              label: 'GitHub',
              onPressed: () => _launchURL('https://github.com/yourusername'),
            ),
            const SizedBox(width: 16),
            _SocialButton(
              icon: Icons.link,
              label: 'LinkedIn',
              onPressed: () => _launchURL('https://linkedin.com/in/yourusername'),
            ),
            const SizedBox(width: 16),
            _SocialButton(
              icon: Icons.link,
              label: 'Twitter',
              onPressed: () => _launchURL('https://twitter.com/yourusername'),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..scale(_isHovered ? 1.1 : 1.0),
        child: OutlinedButton.icon(
          icon: Icon(widget.icon),
          label: Text(widget.label),
          onPressed: widget.onPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
          ),
        ),
      ),
    );
  }
}