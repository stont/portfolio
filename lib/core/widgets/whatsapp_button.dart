// lib/core/widgets/whatsapp_button.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppButton extends StatelessWidget {
  const WhatsAppButton({Key? key}) : super(key: key);

  Future<void> _launchWhatsApp() async {
    final Uri whatsappUrl = Uri.parse('https://wa.me/paperless');
    try {
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl);
      } else {
        throw 'Could not launch WhatsApp';
      }
    } catch (e) {
      debugPrint('Error launching WhatsApp: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: _launchWhatsApp,
      icon: const Icon(Icons.chat_bubble_outline),
      label: const Text('Let\'s chat'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 4,
      tooltip: 'Chat on WhatsApp',
    );
  }
}