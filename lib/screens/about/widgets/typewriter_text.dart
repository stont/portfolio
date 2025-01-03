// lib/screens/about/widgets/typewriter_text.dart
import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final VoidCallback onTypingComplete;

  const TypewriterText({
    Key? key,
    required this.text,
    required this.onTypingComplete,
  }) : super(key: key);

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayText = '';
  int _currentIndex = 0;
  final Duration _typingDelay = const Duration(milliseconds: 5);

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() async {
    while (_currentIndex < widget.text.length) {
      await Future.delayed(_typingDelay);
      if (mounted) {
        setState(() {
          _displayText = widget.text.substring(0, _currentIndex + 1);
          _currentIndex++;
        });
      }
    }
    widget.onTypingComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        height: 1.6,
      ),
    );
  }
}