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
    final isSmallScreen = MediaQuery
        .of(context)
        .size
        .width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect with Me',
          style: Theme
              .of(context)
              .textTheme
              .titleLarge
              ?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap( // Changed from Row to Wrap
          spacing: 12, // horizontal spacing
          runSpacing: 12, // vertical spacing
          children: [
            _SocialButton(
              icon: Icons.link,
              label: 'GitHub',
              onPressed: () => _launchURL('https://github.com/stont'),
            ),
            _SocialButton(
              icon: Icons.link,
              label: 'LinkedIn',
              onPressed: () =>
                  _launchURL('https://linkedin.com/in/davidstont'),
            ),
            _SocialButton(
              icon: Icons.link,
              label: 'Twitter',
              onPressed: () => _launchURL('https://twitter.com/david_stont'),
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
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..scale(_isHovered ? 1.1 : 1.0),
        child: OutlinedButton.icon(
          icon: Icon(
            widget.icon,
            size: isSmallScreen ? 18 : 24,
          ),
          label: Text(
            widget.label,
            style: TextStyle(
              fontSize: isSmallScreen ? 12 : 14,
            ),
          ),
          onPressed: widget.onPressed,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12 : 20,
              vertical: isSmallScreen ? 8 : 12,
            ),
          ),
        ),
      ),
    );
  }
}